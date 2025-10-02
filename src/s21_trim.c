#include "s21_string.h"

void *s21_trim(const char *src, const char *trim_chars) {
  if (src == S21_NULL) return S21_NULL;

  const char *start = src;
  while (*start != '\0' && s21_strchr(trim_chars, *start) != S21_NULL) start++;

  const char *end = start + s21_strlen(start) - 1;
  while (end >= start && s21_strchr(trim_chars, *end) != S21_NULL) end--;

  s21_size_t len = (s21_size_t)(end - start) + 1;
  char *result = (char *)malloc((len + 1) * sizeof(char));
  if (result != S21_NULL) {
    s21_strncpy(result, start, len);
    result[len] = '\0';
  }

  return result;
}