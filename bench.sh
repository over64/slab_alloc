rm ./a.out
clang-9 malloc.c bench.c -O3 -march=native
sudo /usr/bin/time -v perf record ./a.out