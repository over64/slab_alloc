#include <stdio.h>

typedef struct {
  unsigned int rc_and_sc;
  unsigned int n;
  void* data; // ...
} obj_t;

typedef struct {
  unsigned long* ptr_last;
  unsigned int n_last;
  unsigned int entries;
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

void reindex(meta_t* meta) {
  meta->ptr_last[idx_last / 64] = ~meta->ptr_last[idx_last / 64];
}

void* malloc_storage_class(void* sdata, unsigned int size) {
  meta_t* meta = ((meta_t*) sdata) - 1;

  unsigned long last_old =  *(meta->ptr_last);
  unsigned long last_bit = __builtin_ffsl(last_bit);

  if(last_bit == 0)
    reindex(meta);

__builtin_unreachable();
  bit_last--;

  unsigned int n = n_last | (unsigned int) last_bit; // oO

  obj_t* el = &sdata[size * n];
  el->rc_and_sc = 0;
  el->n = n;

  return &el->data;
}

int main() {
}