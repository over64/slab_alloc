#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef union {
  unsigned long rcAndN;
  unsigned int n;
} meta;

typedef struct {
  unsigned int  rc;
  unsigned int  n;
//meta m;
  unsigned long payload;
} obj;

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

  if(entry.current == NULL) {
    printf("cannot allocate slab\n");
    exit(1);
  }
}

void* __attribute__((noinline)) my_malloc(long size) {
  slab* current = entry.current;
  unsigned long l1_value = current->bmap_l1;

  unsigned long shitty = __builtin_ffsl(~l1_value);

  if(shitty != 0) {
    unsigned long idx1 = shitty - 1;

    unsigned long l2_value = current->bmap_l2[idx1];
    shitty = __builtin_ffsl(~l2_value);
    if(shitty  == 0) __builtin_unreachable();
    unsigned long idx2 = shitty - 1;

    unsigned long l3_value = current->bmap_l3[64 * idx1 + idx2];
    shitty = __builtin_ffsl(~l3_value);
    if(shitty  == 0) __builtin_unreachable();
    unsigned long idx3 = shitty - 1;

    unsigned long l4_value = current->bmap_l4[64 * 64 * idx1 + 64 * idx2 + idx3];
    shitty = __builtin_ffsl(~l4_value);
    if(shitty  == 0) __builtin_unreachable();
    unsigned long idx4 = shitty - 1;
    unsigned long l4_value_new = l4_value | (1UL << idx4);
    current->bmap_l4[64 * 64 * idx1 + 64 * idx2 + idx3] = l4_value_new;

    if(l4_value_new == ULONG_MAX) {
      unsigned long l3_value_new = l3_value | (1UL << idx3);
      current->bmap_l3[64 * idx1 + idx2] = l3_value_new;

      if(l3_value_new == ULONG_MAX) {
        unsigned long l2_value_new = l2_value | (1UL << idx2);
        current->bmap_l2[idx1] = l2_value_new;

        if(l2_value_new == ULONG_MAX)
          current->bmap_l1 = l1_value | (1UL << idx1);
      }
    }

    unsigned long n = 64 * 64 * 64 * idx1 + 64 * 64 * idx2 + 64 * idx3 + idx4;
    obj* el = &current->data[n];
    el->n = n; // n << k1 + n << k2
    el->rc = 1;

    return &el->payload;
  } else {
    current->next = entry.full;
    entry.full = current;
    if(entry.partial != NULL) {
      entry.current = entry.partial;
      entry.partial = entry.current->next;
      entry.current->next = NULL;

      return my_malloc(size);
    }

    if(entry.free != NULL) {
      entry.current = entry.free;
      entry.free = entry.current->next;
      entry.current->next = NULL;

      return my_malloc(size);
    }

    entry.current = calloc(sizeof(slab), 1);
    if(entry.current == NULL) {
      printf("out of memory\n");
      exit(1);
    }

    return my_malloc(size);
  }
}

void __attribute__((noinline)) my_free(void* ptr) {
  slab* le = entry.current;
  void* pptr = &ptr[-8];
  obj* el = (obj*) pptr;
//  printf("ptr: %ld pptr: %ld\n", ptr, pptr);
  unsigned long n = el->n;
  unsigned long m = n;

//  unsigned long idx1 = n / 64 / 64 / 64;
//  unsigned long idx2 = (n - idx1 * 64 * 64 * 64) / 64 / 64;
//  unsigned long idx3 = (n - idx1 * 64 * 64 * 64 - idx2 * 64 * 64) / 64 ;
//  unsigned long idx4 = n % 64;

  unsigned long idx4 = n % 64;
  n = n / 64;
  unsigned long idx3 = n % 64;
  n = n / 64;
  unsigned long idx2 = n % 64;
  n = n / 64;
  unsigned long idx1 = n;

  // find my slab???
  

  m = m / 64;
  unsigned long l4map = le->bmap_l4[m]; // ???
  l4map  &= ~(1UL << idx4);
  le->bmap_l4[m] = l4map;

  if(l4map == 0) {
    m = m / 64;
    unsigned long l3map = le->bmap_l3[m];
    l3map &= ~(1UL << idx3);
    le->bmap_l3[m] = l3map;

    if(l3map == 0) {
      m = m / 64;
      unsigned long l2map = le->bmap_l2[m];
      l2map &= ~(1UL << idx2);
      le->bmap_l2[m] = l2map;

      if(l2map == 0) {
        le->bmap_l1 &= ~(1UL << idx1);
      }
    }
  }
}

int main() {
  printf("ffs(0) = %d\n", __builtin_ffsll(0));
  printf("ffs(1) = %d\n", __builtin_ffsll(1) - 1);
  printf("ffs(4096) = %d\n", __builtin_ffsll(4096) - 1);

  my_init();

  long n = 0;

  while(n < 1000) {
    for(int i = 0; i < 16777216; i++)
      my_malloc(16);

    for(int i = 16777215; i >= 0; i--)
      my_free(&(entry.current->data[i].payload));

    n++;
  }

  printf("16777216 * 10^3 iterations done");
}