#include "s21_string.h"

char *s21_strchr(const char *str, int c) {
  int strLength = s21_strlen(str) + 1;
  const char *result = S21_NULL;
  for (int i = 0; i < strLength && result == S21_NULL; i += 1) {
    if (str[i] == c) {
      result = (str + i);
    }
  }
  return (char *)result;
}