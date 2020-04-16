#include <stdio.h>
#include "malloc.h"

extern __thread slab* cslab;

int main() {
  my_init();

  long n = 0;

  while(n < 1000) {
//    printf("n=%ld\n", n);
    for(int i = 0; i < 16777215; i++) {
//      printf("alloc n = %d ", i);
      my_malloc(8);
//      if(my_malloc(16) == NULL) {
//        printf("out of memoryyy\n");
//        exit(1);
//      };
//      n++;
    }


    for(int i = 16777214; i >= 0; i--) {
      my_free(&(cslab->data)[i].payload);
    }
    cslab->meta.n_part = 0;
    cslab->meta.ptr4 = &cslab->bmap_l4[0];


    n++;
  }

  printf("16777216 * 10^3 iterations done");
}