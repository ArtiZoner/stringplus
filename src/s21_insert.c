#include "s21_string.h"

void *s21_insert(const char *src, const char *str, s21_size_t start_index) {
  static char new_str[1024];
  char *result = S21_NULL;
  if (src && str) {
    s21_size_t t1 = s21_strlen(src);
    s21_size_t t2 = s21_strlen(str);
    if (start_index <= t1 && (t1 + t2) < 1024) {
      s21_size_t i = 0, pos = 0;
      for (; i < start_index; i++) {
        new_str[pos++] = src[i];
      }
      for (s21_size_t j = 0; j < t2; j++) {
        new_str[pos++] = str[j];
      }
      for (; i < t1; i++) {
        new_str[pos++] = src[i];
      }
      new_str[pos] = '\0';
      result = new_str;
    }
  }

  return result;
}