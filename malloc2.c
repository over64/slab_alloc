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
  unsigned long idx4; // 0
  unsigned long idx3; // 0
  unsigned long idx2; // 0
  unsigned long l3bit;
  unsigned long l2bit;
  unsigned long l1bit;

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
  slab* current;
  slab* full;
  slab* partial;
  slab* free;
} Entry;

__thread Entry entry;

void my_init() {
  printf("slab size(bytes): %ld\n", sizeof(slab));
  // как влияет calloc?
  entry.current = (slab*) calloc(sizeof(slab), 1);
  entry.full = NULL;
  entry.partial = NULL;
  entry.free = NULL;
  printf("data start(0) = %ld\n", &entry.current->data);

  if(entry.current == NULL) {
    printf("cannot allocate slab\n");
    exit(1);
  }
}


void reindex3(slab* current,  unsigned long idx3) {
}

void reindex2(slab* current, unsigned long idx2, unsigned long idx3) {
}

void reindex1(slab* current, unsigned long idx1, unsigned long idx2, unsigned long idx3) {
}

void* __attribute__((noinline)) my_malloc(long size) {
  // 1. get storage class by size
  // 2. find entry slab for storage class

  slab* current = entry.current; // ???
  unsigned long idx4 = current->idx4;
  unsigned long l4bit = __builtin_ffsl(~current->bmap_l4[idx4]);

  if(__builtin_expect (l4bit != 0, 1)) {
    l4bit--;
    current->bmap_l4[idx4] |= 1UL << (l4bit);

//    printf("%ld %ld %ld %ld %ld\n", current->l1bit, current->idx2, current->idx3, idx4, l4bit);

    unsigned long n = 64 * idx4 + l4bit;

//     printf("l1bit=%ld l2bit=%ld l3bit=%ld l4bit=%ld idx2=%ld idx3=%ld idx4=%ld n=%ld\n", current->l1bit, current->l2bit, current->l3bit, l4bit, current->idx2, current->idx3, idx4, n);
//    printf("%ld\n", n);

    obj* el = &current->data[n];
    el->n = n;
    el->rcAndSc = 0;

    return &el->payload;
  } else {
    unsigned long idx3 = current->idx3;
    current->bmap_l3[idx3] |= 1UL << current->l3bit;
    unsigned long l3bit = __builtin_ffsl(~current->bmap_l3[idx3]);

    if(__builtin_expect(l3bit != 0, 1)) {
      l3bit--;
      current->l3bit = l3bit;
      current->idx4 = 64 * idx3 + l3bit;

      return my_malloc(size);
    } else {
//      printf("here1!\n");
      unsigned long idx2 = current->idx2;
      current->bmap_l2[idx2] |= 1UL << current->l2bit;
      unsigned long l2bit = __builtin_ffsl(~current->bmap_l2[idx2]);

      if(__builtin_expect(l2bit != 0, 1)) {
//        printf("here2!\n");
        l2bit--;
//        printf("l2bit=%ld\n", l2bit);
        current->l2bit = l2bit;
        current->idx3 = 64 * idx2 + l2bit;

        l3bit = __builtin_ffsl(~current->bmap_l3[current->idx3]);
        if(l3bit == 0) __builtin_unreachable();
        l3bit--;
        current->l3bit = l3bit;
//        printf("l3bit=%ld\n", l3bit);

        current->idx4 = 64 * current->idx3 + l3bit;

        return my_malloc(size);
      } else {
        current->bmap_l1 |= 1UL << current->l1bit;
        unsigned long l1bit = __builtin_ffsl(~current->bmap_l1);

        if(__builtin_expect(l1bit != 0, 1)) {
          l1bit--;
          current->l1bit = l1bit;
          current->idx2 = l1bit;

          l2bit = __builtin_ffsl(~current->bmap_l2[current->idx2]);
          if(l2bit == 0) __builtin_unreachable();
          l2bit--;
          current->l2bit = l2bit;
          current->idx3 = 64 * current->idx2 + l2bit;

          l3bit = __builtin_ffsl(~current->bmap_l3[current->idx3]);
          if(l3bit == 0) __builtin_unreachable();
          l3bit--;
          current->l3bit = l3bit;
          current->idx4 = 64 * current->idx3 + l3bit;          

          return my_malloc(size);
        } else {
          printf("out of memory\n");
          printf("l1bit=%ld idx2=%ld idx3=%ld idx4=%ld", current->l1bit, current->idx2, current->idx3, current->idx4);
          exit(1);
        }
      }
    }
  }
}

void __attribute__((always_inline)) free_storage_class(void* ptr, unsigned long m, unsigned long size) {

  void* data_start = &ptr[-m * size];
  unsigned long* lptr = (unsigned long*) data_start;

  unsigned long* l4_start = &lptr[-64*64*64];
  unsigned long idx4 = m % 64;
  m = m / 64;
  unsigned long l4map = l4_start[m];
  l4map  &= ~(1UL << idx4);
  l4_start[m] = l4map;

  if(__builtin_expect(l4map == 0, 0)) {
    unsigned long* l3_start = &l4_start[-64 * 64];
    unsigned long idx3 = m % 64;
    m = m / 64;
    unsigned long l3map = l3_start[m];
    l3map &= ~(1UL << idx3);
    l3_start[m] = l3map;

    if(__builtin_expect(l3map == 0, 0)) {
      unsigned long* l2_start = &l3_start[-64];
      unsigned long idx2 = m % 64;
      m = m / 64;
      unsigned long l2map = l2_start[m];
      l2map &= ~(1UL << idx2);
      l2_start[m] = l2map;

      if(__builtin_expect(l2map == 0, 0)) {
        unsigned long* l1_start = &l2_start[-1];
        unsigned long idx1 = m;
        l1_start[0] &= ~(1UL << idx1);
      }
    }
  }
}

unsigned long sc_to_size[] = {16, 32, 48, 48};

void __attribute__((noinline)) my_free(void* ptr) {
  void* pptr = &ptr[-8];
  obj* el = (obj*) pptr;
  unsigned long m = el->n;

  free_storage_class(pptr, m, sc_to_size[el->rcAndSc]);
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
      my_free(&(entry.current->data[i].payload));

    n++;
  }

  printf("16777216 * 10^3 iterations done");
}
