rm ./a.out
clang-9 malloc.c test.c -O3 -march=native
./a.out