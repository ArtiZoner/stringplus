#include "s21_string.h"

s21_size_t s21_strlen(const char *str) {
  s21_size_t str_len = 0;
  for (; *str != '\0'; str++) {
    str_len += 1;
  }
  return str_len;
}