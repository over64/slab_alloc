typedef struct {
  unsigned int  rcAndSc;
  unsigned int  n;
  unsigned long payload;
} obj;

typedef struct meta_t {
  unsigned long* ptr4;
  unsigned long size;
  unsigned int is_full;
  unsigned int n_part;
  unsigned long* l_start[4];
} meta_t;

typedef struct slab {
//  unsigned long __cacheline_pad__[7];
  unsigned long bmap_l1;
  unsigned long bmap_l2[64];
  unsigned long bmap_l3[4096];
  unsigned long bmap_l4[262144];
  meta_t meta;
  obj data[16777216];
  struct slab* next;
} slab;

typedef struct {
  //__attribute__((aligned(64)))
  meta_t* slabs[2];
  slab* full;
  slab* partial;
  slab* free;
} Entry;

void  my_init();
void* my_malloc(unsigned long size);
void  my_free(void* ptr);