#include "s21_string.h"

char *s21_strncat(char *dest, const char *src, s21_size_t n) {
  s21_size_t destLength = s21_strlen(dest);
  s21_size_t i = 0;
  for (; i < n && src[i] != '\0'; i++) {
    dest[destLength + i] = src[i];
  }
  dest[destLength + i] = '\0';

  return dest;
}