#include "s21_string.h"

void *s21_memcpy(void *dest, const void *src, s21_size_t n) {
  const unsigned char *ptr = (unsigned char *)src;
  unsigned char *arrdest = (unsigned char *)dest;
  for (s21_size_t i = 0; i < n; i++) {
    arrdest[i] = ptr[i];
  }
  return dest;
}