#include "s21_string.h"

char *s21_strpbrk(const char *str1, const char *str2) {
  s21_size_t strLength = s21_strlen(str1);
  s21_size_t shift = 0;
  int status = 0;
  const char *result = S21_NULL;
  for (shift = 0; status == 0 && shift < strLength; shift += 1) {
    if (s21_strchr(str2, str1[shift])) {
      status = 1;
      result = (char *)(str1 + shift);
    }
  }
  return (char *)result;
}