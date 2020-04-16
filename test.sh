rm ./a.out
clang-9 malloc.c test.c -march=native -g
#valgrind ./a.out
 ./a.out