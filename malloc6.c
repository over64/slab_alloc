#include <stdio.h>

typedef struct {
  unsigned int rc_and_sc;
  unsigned int n;
  void* data; // ...
} obj_t;

typedef struct {
  unsigned long* ptr_last;
  unsigned long cl[5]; // all ULONG_MAX but last zero
  unsigned int idx_last;
} meta_t;

typedef struct {
  unsigned long l1;
  unsigned long l2[64];
  unsigned long l3[4096];
  unsigned long l4[262144];

  meta_t meta;
  obj_t data[16777216];
  struct slab* next;
} slab_t;

void reindex(meta_t* meta, unsigned int idx_last) {
  meta->ptr_last[idx_last / 64] = ~meta->ptr_last[idx_last / 64];

}

void* malloc_storage_class(void* sdata, unsigned int size) {
  meta_t* meta = ((meta_t*) sdata) - 1;

  unsigned int  idx_last = meta->idx_last;
  unsigned long cache_last = meta->cl[4];
  unsigned long bit_last =  __builtin_ffsl(cache_last);

  if(bit_last == 0) __builtin_unreachable();
  bit_last--;

  cache_last ^= 1UL << bit_last;
  meta->cl[4] = cache_last;
  if(__builtin_expect(cache_last == 0, 0))
    reindex(meta, idx_last);

  unsigned int n = idx_last | (unsigned int) bit_last; // oO

  obj_t* el = &sdata[size * n];
  el->rc_and_sc = 0;
  el->n = n;

  return &el->data;
}

int main() {
}