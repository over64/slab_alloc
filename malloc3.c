#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef union {
  unsigned long rcAndN;
  unsigned int n;
} meta;

typedef struct {
  unsigned int  rcAndSc;
  unsigned int  n;
//meta m;
  unsigned long payload;
} obj;

typedef struct {
  unsigned long bmap_l1;
  long bmap_l2[64];
  long bmap_l3[4096];
  long bmap_l4[262144];
} maps_t;

typedef struct slab {
  unsigned long bmap_l1;
  long bmap_l2[64];
  long bmap_l3[4096];
  long bmap_l4[262144];

  //struct slab* next;
//  unsigned long k1;
//  unsigned long k2;
  obj  data[16777216];
//  obj data[64];
//  obj data[4096];
//  obj data[262144];
  struct slab* next;
} slab;

typedef struct {
  unsigned int idx4; // 0
  unsigned int idx3; // 0
  unsigned int idx2; // 0
  unsigned int l3bit;
  unsigned int l2bit;
  unsigned int l1bit;

  void* current_data;
  slab* full;
  slab* partial;
  slab* free;
} Entry;

__thread Entry entry;

void my_init() {
  printf("slab size(bytes): %ld\n", sizeof(slab));
  // как влияет calloc?
  entry.current_data = &((slab*) calloc(sizeof(slab), 1))->data;
  entry.full = NULL;
  entry.partial = NULL;
  entry.free = NULL;
  printf("data start(0) = %ld\n", &entry.current_data);

//  if(entry.current == NULL) {
//    printf("cannot allocate slab\n");
//    exit(1);
//  }
}


void reindex3(slab* current,  unsigned long idx3) {
}

void reindex2(slab* current, unsigned long idx2, unsigned long idx3) {
}

void reindex1(slab* current, unsigned long idx1, unsigned long idx2, unsigned long idx3) {
}

void* __attribute__((always_inline)) malloc_tail(obj* current_data, unsigned long* l4_start, unsigned int idx4, unsigned long l4bit) {
  l4_start[idx4] |= 1UL << l4bit;
  unsigned int n = 64 * idx4 + (unsigned int) l4bit;

  obj* el = &current_data[n];
  el->rcAndSc = 0;
  el->n = n;

  return &el->payload;
}

void* __attribute__((noinline)) my_malloc(long size) {
  // 1. get storage class by size
  // 2. find entry slab for storage class

  void *ptr = entry.current_data;
  obj* current_data = (obj*) ptr; // ???
  unsigned long* l4_start = (unsigned long*) (ptr - 64 * 64 * 64 * 8);
  unsigned int idx4 = entry.idx4;
  unsigned long l4bit = __builtin_ffsl(~l4_start[idx4]);

  if(__builtin_expect(l4bit != 0, 1))
    return malloc_tail(current_data, l4_start, idx4, l4bit - 1);
 

  unsigned long* l3_start = l4_start - 64 * 64;
  unsigned int idx3 = entry.idx3;
  l3_start[idx3] |= 1UL << entry.l3bit;
  unsigned int l3bit = __builtin_ffsl(~l3_start[idx3]);

  if(__builtin_expect(l3bit != 0, 1)) {
    l3bit--;
    entry.l3bit = l3bit;
    idx4 = 64 * idx3 + l3bit;
    entry.idx4 = idx4;
    l4bit = __builtin_ffsl(~l4_start[idx4]);
    if(l4bit == 0) __builtin_unreachable();

    return malloc_tail(current_data, l4_start, idx4, l4bit - 1);
  }

  unsigned long* l2_start = l3_start - 64;
  unsigned int idx2 = entry.idx2;
  l2_start[idx2] |= 1UL << entry.l2bit;
  unsigned int l2bit = __builtin_ffsl(~l2_start[idx2]);

  if(__builtin_expect(l2bit != 0, 1)) {
    l2bit--;
    entry.l2bit = l2bit;
    entry.idx3 = 64 * idx2 + l2bit;

    l3bit = __builtin_ffsl(~l3_start[entry.idx3]);
    if(l3bit == 0) __builtin_unreachable();
    l3bit--;
    entry.l3bit = l3bit;
    idx4 = 64 * entry.idx3 + l3bit;
    l4bit = __builtin_ffsl(~l4_start[idx4]);
    if(l4bit == 0) __builtin_unreachable();
    entry.idx4 = 64 * entry.idx3 + l3bit;

    return malloc_tail(current_data, l4_start, idx4, l4bit - 1);
  }

  unsigned long* l1_start = l2_start - 1;
  l1_start[0] |= 1UL << entry.l1bit;
  unsigned int l1bit = __builtin_ffsl(~l1_start[0]);

  if(__builtin_expect(l1bit != 0, 1)) {
    l1bit--;
    entry.l1bit = l1bit;
    entry.idx2 = l1bit;

    l2bit = __builtin_ffsl(~l2_start[entry.idx2]);
    if(l2bit == 0) __builtin_unreachable();
    l2bit--;
    entry.l2bit = l2bit;
    entry.idx3 = 64 * entry.idx2 + l2bit;
    l3bit = __builtin_ffsl(~l3_start[entry.idx3]);
    if(l3bit == 0) __builtin_unreachable();
    l3bit--;
    entry.l3bit = l3bit;
    idx4 = 64 * entry.idx3 + l3bit;
    l4bit = __builtin_ffsl(~l4_start[idx4]);
    if(l4bit == 0) __builtin_unreachable();
    entry.idx4 = 64 * entry.idx3 + l3bit;

    return malloc_tail(current_data, l4_start, idx4, l4bit - 1);
  }

  //printf("out of memory\n");
  //printf("l1bit=%ld idx2=%ld idx3=%ld idx4=%ld", entry.l1bit, entry.idx2, entry.idx3, entry.idx4);
  //exit(1);
  return NULL;
}

typedef struct {
  int size;
  int entries;
} sclass_t;

sclass_t classes[] = {{ -16, -262145 }, { -32, -262145 }};
//long class_to_size[] = {-16, -32};
//long class_to_entries[] = {-262145, -262145};

unsigned long shl_inv(unsigned long x, unsigned long n) {
  return ~(x << n);
}


void __attribute__((always_inline)) free_storage_class(void* ptr, unsigned int m, long size, long entries) {

  void* data_start = &ptr[m * size];
  unsigned long* lptr = (unsigned long*) data_start;

  unsigned long* l4_start = &lptr[entries];
  unsigned long idx4 = m % 64;
  m = m / 64;
  unsigned long l4map = l4_start[m];
  //if(idx4 > 63) __builtin_unreachable();
  unsigned long x = shl_inv(1UL, idx4);

  l4map ^= 1UL << idx4;
  l4_start[m] = l4map;

  if(__builtin_expect(l4map == 0, 0)) {
    entries /= 64;
    unsigned long* l3_start = &l4_start[entries];
    unsigned long idx3 = m % 64;
    m = m / 64;
    unsigned long l3map = l3_start[m];
    l3map ^= 1UL << idx3;
    l3_start[m] = l3map;

    if(__builtin_expect(l3map == 0, 0)) {
      entries = entries / 64;
      unsigned long* l2_start = &l3_start[entries];
      unsigned long idx2 = m % 64;
      m = m / 64;
      unsigned long l2map = l2_start[m];
      l2map ^= 1UL << idx2;
      l2_start[m] = l2map;

      if(__builtin_expect(l2map == 0, 0)) {
        entries = entries / 64;
        unsigned long* l1_start = &l2_start[entries];
        unsigned long idx1 = m;
        l1_start[0] ^= 1UL << idx1;
      }
    }
  }
}

void __attribute__((noinline)) my_free(void* ptr) {
  void* pptr = &ptr[-8];
  obj* el = (obj*) pptr;
  unsigned int m = el->n;
  int rcAndSc = el->rcAndSc;
  sclass_t class = classes[el->rcAndSc];

  free_storage_class(ptr, m, class.size, class.entries);
}

int main() {
  printf("ffs(0) = %d\n", __builtin_ffsll(0));
  printf("ffs(1) = %d\n", __builtin_ffsll(1) - 1);
  printf("ffs(4096) = %d\n", __builtin_ffsll(4096) - 1);

  my_init();

  long n = 0;

  while(n < 1000) {
    for(int i = 0; i < 16777216; i++) {
//      printf("%ld\n", n);
      my_malloc(16);
//      n++;
    }

    for(int i = 16777215; i >= 0; i--)
      my_free(&(((obj*)entry.current_data)[i].payload));

    n++;
  }

  printf("16777216 * 10^3 iterations done");
}

unsigned long inv(unsigned long w) {
  return ~w;
}