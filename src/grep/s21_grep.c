#include "s21_grep.h"

int main(int argc, char *argv[]) {
  grep options = {0};
  needs need = {0};
  Parser(argc, argv, &options, &need);
  while (optind < argc) {
    Output(argv, &options, &need);
    optind++;
  }
  return 0;
}

void Parser(int argc, char **argv, grep *options, needs *need) {
  int optionss;
  while ((optionss = getopt(argc, argv, "e:ivclnhsf:o")) != -1) {
    switch (optionss) {
      case 'e':
        options->e = 1;
        strcat(need->str_regexes, optarg);
        strcat(need->str_regexes, "|");
        break;
      case 'i':
        options->i = 1;
        break;
      case 'v':
        options->v = 1;
        break;
      case 'c':
        options->c = 1;
        break;
      case 'l':
        options->l = 1;
        break;
      case 'n':
        options->n = 1;
        break;
      case 'h':
        options->h = 1;
        break;
      case 's':
        options->s = 1;
        break;
      case 'o':
        options->o = 1;
        break;
      case 'f':
        options->f = 1;
        strcpy(need->filename, optarg);
        Flag_f(need);
        break;
      default:
        fprintf(stderr, "Fail, no option: %c\n", optopt);
        break;
    }
  }
  if (!options->e && !options->f) {
    if (argc > optind) strcat(need->str_regexes, argv[optind]);
    optind++;
  }
  if (options->e || options->f)
    need->str_regexes[strlen(need->str_regexes) - 1] = '\0';
  if (argc - optind > 1) need->mult_files = 1;
}

void Flag_f(needs *need) {
  FILE *file = fopen(need->filename, "rb");
  if (file != NULL) {
    while (fgets(need->str, 2000, file) != NULL) {
      size_t len = strlen(need->str);
      if (need->str[len - 1] == '\n' && len > 0) need->str[len - 1] = '\0';
      strcat(need->str_regexes, need->str);
      strcat(need->str_regexes, "|");
    }
    fclose(file);
  }
}

void Flag_O(needs *need) {
  char *ptr = need->str_o;
  while ((regexec(&need->reg, ptr, 1, &need->matches, 0) == 0)) {
    printf("%.*s\n", (int)(need->matches.rm_eo - need->matches.rm_so),
           ptr + need->matches.rm_so);
    ptr += need->matches.rm_eo;
  }
}

void Output(char **argv, const grep *options, needs *need) {
  FILE *file;
  int flag_i = REG_EXTENDED;
  if (options->i) flag_i = REG_EXTENDED | REG_ICASE;
  regcomp(&need->reg, need->str_regexes, flag_i);
  file = fopen(argv[optind], "rb");
  if (file != NULL) {
    int counter_lines = 0, str_number = 0;
    while (fgets(need->str, BUFFER, file) != NULL) {
      str_number++;
      int match = regexec(&need->reg, need->str, 1, &need->matches, 0);
      if (options->o) strcpy(need->str_o, need->str);
      if (!match && options->n && !options->c && !options->l) {
        if (options->o) {
          printf("%d:", str_number);
        } else
          printf("%d:%s", str_number, need->str);
        if (need->str[strlen(need->str) - 1] != '\n') printf("\n");
      }
      if ((!match || options->v) && need->mult_files && !options->l &&
          !options->h && !options->c)
        printf("%s:", argv[optind]);
      if (!match) counter_lines++;
      if (options->v) match = !match;
      if (!match && !options->l && !options->c && !options->n && !options->o) {
        printf("%s", need->str);
        if (need->str[strlen(need->str) - 1] != '\n') printf("\n");
      }
      if (!match && options->o && !options->l && !options->c) Flag_O(need);
    }
    regfree(&need->reg);
    if (options->l && counter_lines < 1 && options->v)
      printf("%s\n", argv[optind]);
    if (options->l && counter_lines > 0) printf("%s\n", argv[optind]);
    if (options->c && need->mult_files && !options->h && !options->l)
      printf("%s:", argv[optind]);
    if (options->c && !options->l && !options->v) printf("%d\n", counter_lines);
    if (options->c && !options->l && options->v)
      printf("%d\n", str_number - counter_lines);
    fclose(file);
  } else {
    regfree(&need->reg);
    if (!options->s)
      fprintf(stderr, "grep: %s: No such file or directory\n", argv[optind]);
  }
}
