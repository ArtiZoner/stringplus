#include "s21_string.h"

char *s21_strtok(char *str, const char *delim) {
  static char *nexttok = S21_NULL;
  if (str == S21_NULL) {
    str = nexttok;
  }
  if (delim != S21_NULL && str != S21_NULL) {
    nexttok = S21_NULL;
    for (s21_size_t i = 0; str[i] && nexttok == S21_NULL; i++) {
      if (s21_strchr(delim, (int)str[i])) {
        if (i == 0) {
          i--;
          str += 1;
        } else {
          if (str[i + 1]) nexttok = &str[i + 1];
          str[i] = '\0';
        }
      }
    }
  }
  return (*str) ? str : S21_NULL;
}