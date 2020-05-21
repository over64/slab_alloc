#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include "malloc.h"

__attribute__((aligned(64)))
__thread Entry entry;
__thread slab* cslab;

void my_init() {
  printf("slab size(bytes): %ld\n", sizeof(slab));
  // как влияет calloc?
  cslab = (slab*) calloc(sizeof(slab), 1);
  cslab->meta.ptr4 = &cslab->bmap_l4[0];
  cslab->meta.size = 16;

  cslab->meta.l_start[3] = &cslab->bmap_l4[0];
  cslab->meta.l_start[2] = &cslab->bmap_l3[0];
  cslab->meta.l_start[1] = &cslab->bmap_l2[0];
  cslab->meta.l_start[0] = &cslab->bmap_l1;

  for(int i = 0; i < 16777215; i++) {
    cslab->data[i].n = i;
    cslab->data[i].rcAndSc = 1;
  }

  entry.slabs[0] = NULL;
//  entry.slabs[1] = NULL;
  entry.slabs[1] = &(cslab)->meta;
  entry.full = NULL;
  entry.partial = NULL;
  entry.free = NULL;
  printf("meta start = %p\n", &cslab->meta);
  printf("data start(0) = %p\n", &cslab->data[0]);
  printf("l4_start(0) = %p\n", &cslab->bmap_l4[0]);
  printf("meta.ptr4 = %p\n", &cslab->meta.ptr4);

//  if(entry.current == NULL) {
//    printf("cannot allocate slab\n");
//    exit(1);
//  }
}

void __attribute((always_inline)) my_reindex(meta_t* meta, unsigned int n_part) {
  unsigned int idx4 = n_part / 64;
  unsigned long l1bit, l2bit, l3bit, l4bit;
  unsigned int idx3, idx2;

  goto ii4;
ii1:
  // alloc new slab
  while(1); // but now die
  goto ii2_tail;
ii2:
  meta->l_start[0][0] |= 1UL << (idx2 % 64);
ii2_tail:
  l1bit = __builtin_ffsl(~meta->l_start[0][0]);
  if(__builtin_expect(l1bit == 0, 0)) goto ii1; else l1bit--;
  idx2 = (unsigned int) l1bit;
  goto ii3_tail;
ii3:
  idx2 = idx3 / 64;
  meta->l_start[1][idx2] |= 1UL << (idx3 % 64);
ii3_tail:
  l2bit = __builtin_ffsl(~meta->l_start[1][idx2]);
  if(__builtin_expect(l2bit == 0, 0)) goto ii2; else l2bit--;
  idx3 = 64 * idx2 + (unsigned int) l2bit;
  goto ii4_tail;
ii4:
  idx3 = idx4 / 64;
  meta->l_start[2][idx3] |= 1UL << (idx4 % 64);
ii4_tail:
  l3bit = __builtin_ffsl(~meta->l_start[2][idx3]);
  if(__builtin_expect(l3bit == 0, 0)) goto ii3; else l3bit--;
  idx4 = 64 * idx3 + (unsigned int) l3bit;
  meta->ptr4 = &meta->l_start[3][idx4];
  meta->n_part = idx4 * 64;
}

void* __attribute__((noinline)) my_malloc(unsigned long size) {
  unsigned int sclass = size / 8;

  if(__builtin_expect(sclass > 12, 0)) // by 8
    if(__builtin_expect(sclass > 52, 0)) // by 16
      if(__builtin_expect(sclass > 176, 0)) // by 64
        if(__builtin_expect(sclass > 672, 0)) // by 256
          if(__builtin_expect(sclass > 2688, 0)) // by 1024
            if(__builtin_expect(sclass > 10752, 0)) // by 4096
              while(1);
            else sclass = 12 + (size - 96) / 16;
          else sclass = 32 + (size - 416) / 64;
        else sclass = 48 + (size - 1408) / 256;
      else sclass = 64 + (size - 5376) / 1024;
    else sclass = 80 + (size - 21504) / 4096;

  meta_t *meta = entry.slabs[sclass];
  void* current_data = (void*)(meta + 1);
  unsigned int n_part = meta->n_part;
  //unsigned long class_size = meta->size;

  unsigned long l4old = *(meta->ptr4);
  unsigned long l4bit = __builtin_ffsl(~l4old);
  if(l4bit == 0) __builtin_unreachable(); else l4bit--;

  unsigned long l4new = l4old | (1UL << l4bit);
  *meta->ptr4 = l4new;

  unsigned int n = n_part | (unsigned int) l4bit;
//  printf("el.n = %d\n", n);

  unsigned long class_size = meta->size;
  obj* el = (obj*) &current_data[n * class_size];
//  el->rcAndSc = sclass;
//  el->n = n;

  void* result = &el->payload;
//  printf("res = %p\n", result);
//  exit(1);

  //if(__builtin_expect(__builtin_popcountl(l4old) == 63, 0))
  if(__builtin_expect(l4new == ULONG_MAX, 0))
    my_reindex(meta, n_part);

  return result;
}

typedef struct {
  int size;
  int entries;
} sclass_t;

sclass_t classes[] = {
  { -16,  -262144 - 1 - sizeof(meta_t) / 8 }, // [0..8]
  { -16,  -262144 - 1 - sizeof(meta_t) / 8 }, // [9..16]
};

// engine to calc classes

//long class_to_size[] = {-16, -32};
//long class_to_entries[] = {-262145, -262145};


void __attribute__((always_inline)) free_storage_class(unsigned int m, unsigned long** levels) {

  //printf("here 4\n");
  //printf("free n = %d\n", m);

//  unsigned long* l4_start = &lptr[entries];
//  printf("free l4_start=%ld\n", l4_start);
 // exit(1);
  //printf("free m=%u\n", m);
  unsigned long idx4 = m % 64;
  m = m / 64;
  unsigned long l4map = levels[-1][m];
  levels[-1][m] &= ~(1UL << idx4);

  if(__builtin_expect(l4map != ULONG_MAX, 1))
    return;

  //printf("here 3\n");

  unsigned long idx3 = m % 64;
  m = m / 64;
  unsigned long l3map = levels[-2][m];
  levels[-2][m] &= ~(1UL << idx3);

  if(__builtin_expect(l3map != ULONG_MAX, 1))
    return;

  //printf("here 2\n");

//  entries = entries / 64;
//  unsigned long* l2_start = &l3_start[entries];
  unsigned long idx2 = m % 64;
  m = m / 64;
  unsigned long l2map = levels[-3][m];
  levels[-3][m] &= ~(1UL << idx2);

  if(__builtin_expect(l2map != ULONG_MAX, 1))
    return;

  //printf("here 1\n");

//  entries = entries / 64;
 // unsigned long* l1_start = &l2_start[entries];
  unsigned long idx1 = m;
  levels[-4][0] &= ~(1UL << idx1);
}

void __attribute__((noinline)) my_free(void* ptr) {
  void* pptr = &ptr[-8];
  obj* el = (obj*) pptr;
  unsigned int m = el->n;
  unsigned int sclass = el->rcAndSc;

  unsigned int size = 8 + 8 * sclass; // by 8
  unsigned long off;
  void* meta_last;
  if(__builtin_expect(sclass > 12, 0)) goto find;
found:
  off = m * size;
  meta_last = pptr - off;
//  printf("m = %lu, ptr = %p, pptr = %p, off = %lu, meta_last = %p\n", m, ptr, pptr, off, meta_last);
  free_storage_class(m, (unsigned long**) meta_last);
  return;
find:
  if(     __builtin_expect(sclass < 32, 0)) // by 16
    size = 8 + 96 + (sclass - 12) * 16;
  else if(__builtin_expect(sclass < 48, 0)) // by 64
    size = 8 + 416 + (sclass - 48) * 64;
  else if(__builtin_expect(sclass < 64, 0)) // by 256
    size = 8 + 1408 + (sclass - 64) * 256;
  else if(__builtin_expect(sclass < 80, 0)) // by 1024
    size = 8 + 5376 + (sclass - 64) * 1024;
  else if(__builtin_expect(sclass > 96, 0)) // by 4096
    size = 8 + 21504 + (sclass - 80) * 4096;
  else                                      // MMAP
    while(1);

  goto found;
}
