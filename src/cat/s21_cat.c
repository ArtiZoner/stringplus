#include "s21_cat.h"

int main(int argc, char **argv) {
  int trouble = 0;
  ;
  opt options = {0};
  for (int i = 1; i < argc; i++) {
    if (argv[i][0] == '-' && argv[i][1] != '-') {
      for (int k = 1; argv[i][k]; k++) {
        switch (argv[i][k]) {
          case 'n':
            options.n = 1;
            break;
          case 'b':
            options.b = 1;
            break;
          case 's':
            options.s = 1;
            break;
          case 'E':
            options.E = 1;
            break;
          case 'T':
            options.T = 1;
            break;
          case 'e':
            options.e = 1;
            break;
          case 't':
            options.t = 1;
            break;
          case 'v':
            options.v = 1;
            break;
          default:
            puts("Non-existing option, retreat!!!\n");
            trouble = 1;
        }
      }
    } else if (argv[i][0] == '-' && argv[i][1] == '-') {
      if (strcmp(argv[i], "--number-nonblank") == 0) {
        options.b = 1;
      }
      if (strcmp(argv[i], "--number") == 0) {
        options.n = 1;
      }
      if (strcmp(argv[i], "--squeeze-blank") == 0) {
        options.s = 1;
      } else {
        trouble = 1;
      }
    }
  }
  if (!trouble) {
    for (int i = 1; i < argc; i++) {
      if (argv[i][0] != '-') {
        cat_file(argv[i], options);
      }
    }
  } else {
    printf("Write options or file\n");
  }
  return 0;
}

void invert(int *ch) {
  if (*ch <= 31 && *ch != 9 && *ch != 10) {
    *ch += 64;
    printf("^");
  } else if (*ch == 127) {
    *ch -= 64;
    printf("^");
  } else if (*ch > 126 && *ch < 160) {
    *ch -= 64;
    printf("M-^");
  } else if (*ch >= 160) {
    *ch -= 128;
    printf("M-");
  }
}

void file_output(FILE *file_name, opt options) {
  char prev = '\n';
  int ch;
  int line_num = 1;
  int empty_line = 0;

  while ((ch = fgetc(file_name)) != EOF) {
    if (options.s && ch == '\n' && prev == '\n') {
      empty_line++;
      if (empty_line > 1) {
        continue;
      }
    } else {
      empty_line = 0;
    }
    if (prev == '\n') {
      if ((options.n) || (options.b && ch != '\n')) {
        printf("%6d\t", line_num++);
      }
    }

    if ((!options.t && !options.e) && options.v) {
      invert(&ch);
    }

    if ((options.e && ch == '\n') || (options.E && ch == '\n')) {
      putchar('$');
    }

    if ((options.t && ch == '\t') || (options.T && ch == '\t')) {
      putchar('^');
      putchar('I');
    } else {
      putchar(ch);
    }

    prev = ch;
  }
}

void cat_file(const char *filename, opt options) {
  if (strcmp(filename, "-") == 0) {
    file_output(stdin, options);
    return;
  }

  FILE *file = fopen(filename, "r");
  if (!file) {
    perror("Error");
    return;
  }

  file_output(file, options);
  fclose(file);
}