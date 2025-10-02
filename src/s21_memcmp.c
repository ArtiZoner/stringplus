#include "s21_string.h"

int s21_memcmp(const void *str1, const void *str2, s21_size_t n) {
  const unsigned char *ptr1, *ptr2;
  ptr1 = str1;
  ptr2 = str2;
  for (s21_size_t i = 0; i < n; i++) {
    if (ptr1[i] != ptr2[i]) {
      return (ptr1[i] > ptr2[i]) ? 1 : -1;
    }
  }
  return 0;
}