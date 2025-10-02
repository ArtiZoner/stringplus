#include "s21_string.h"

char *s21_strncpy(char *dest, const char *src, s21_size_t n) {
  s21_size_t srcLength = s21_strlen(src);
  s21_size_t cpyLength = 0;
  if (n > srcLength) {
    cpyLength = srcLength + 1;
  } else {
    cpyLength = n;
  }

  for (s21_size_t i = 0; i < cpyLength; i += 1) {
    dest[i] = src[i];
  }

  return dest;
}