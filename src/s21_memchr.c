#include "s21_string.h"

void *s21_memchr(const void *str, int c, s21_size_t n) {
  const unsigned char *ptr = str;
  s21_size_t success = n;
  unsigned char ch = (const unsigned)c;
  for (s21_size_t i = 0; i < n; i++) {
    if (ptr[i] == ch) {
      success = i;
    }
  }
  return success == n ? S21_NULL : (void *)(str + success);
}