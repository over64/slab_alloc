#include <stdio.h>
#include <limits.h>
#include <stdlib.h>
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
    
    printf("iter = %ld\n", n);



    for(int i = 0; i < 262143; i++) {
      if(cslab->bmap_l4[i] != ULONG_MAX) {
        printf("assertion failed on l4 at %d\n", i);
        exit(1);
      }
    }

    for(int i = 0; i < 4095; i++) {
      if(cslab->bmap_l3[i] != ULONG_MAX) {
        printf("assertion failed on l3 at %d\n", i);
        exit(1);
      }
    }

    for(int i = 0; i < 63; i++) {
      if(cslab->bmap_l2[i] != ULONG_MAX) {
        printf("assertion failed on l2\n");
        exit(1);
      }
    }

   //if(cslab->bmap_l1 != ULONG_MAX) {
//     printf("assertion failed on l1\n");
//     exit(1);
  // }


    for(int i = 16777214; i >= 0; i--) {
//      printf("free(%d)\n", i);
      my_free(&cslab->data[i].payload);
    }
    cslab->meta.n_part = 0;
    cslab->meta.ptr4 = &cslab->bmap_l4[0];



    for(int i = 0; i < 262144; i++) {
      if(cslab->bmap_l4[i] != 0) {
        printf("free assertion failed on l4 at %d with %lu \n", i, cslab->bmap_l4[i]);
        exit(1);
      }
    }

    for(int i = 0; i < 4096; i++) {
      if(cslab->bmap_l3[i] != 0) {
        printf("free assertion failed on l3 at %d\n", i);
        exit(1);
      }
    }

    for(int i = 0; i < 64; i++) {
      if(cslab->bmap_l2[i] != 0) {
        printf("free assertion failed on l2\n");
        exit(1);
      }
    }

   if(cslab->bmap_l1 != 0) {
     printf("free assertion failed on l1\n");
     exit(1);
   }


    n++;
  }

  printf("16777216 * 10^3 iterations done");
}