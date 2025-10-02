#include "s21_string.h"

char *s21_strrchr(const char *str, int c) {
  int strLength = s21_strlen(str);
  const char *result = S21_NULL;
  for (int i = strLength; result == S21_NULL && i >= 0; i -= 1) {
    if (str[i] == c) {
      result = (str + i);
    }
  }
  return (char *)result;
}