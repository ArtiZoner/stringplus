#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  int n;
  int b;
  int e;
  int E;
  int s;
  int t;
  int T;
  int v;
} opt;

void invert(int *ch);
void cat_file(const char *filename, opt options);
void file_output(FILE *file_name, opt options);
