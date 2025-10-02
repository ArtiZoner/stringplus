#ifndef S21_GREP_H
#define S21_GREP_H

#include <getopt.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BUFFER 4096

typedef struct {
  int e;
  int i;
  int v;
  int c;
  int l;
  int n;
  int h;
  int s;
  int f;
  int o;
} grep;

typedef struct {
  char str[BUFFER];
  char str_regexes[BUFFER];
  char mult_files;
  char str_o[BUFFER];
  char filename[BUFFER];
  regex_t reg;
  regmatch_t matches;
} needs;

void Parser(int argc, char **argv, grep *options, needs *need);
void Output(char **argv, const grep *options, needs *need);
void Flag_f(needs *need);
void Flag_O(needs *need);

#endif