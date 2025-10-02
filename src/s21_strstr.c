#include "s21_string.h"

char *s21_strstr(const char *haystick, const char *needle) {
  s21_size_t srcptrLength = s21_strlen(needle);
  const char *result = S21_NULL;

  if (srcptrLength != 0) {
    for (int i = 0; result == S21_NULL && haystick[i] != '\0'; i += 1) {
      if (haystick[i] == needle[0]) {
        if (s21_strncmp(haystick + i, needle, srcptrLength) == 0)
          result = haystick + i;
      }
    }
  } else {
    result = haystick;
  }
  return (char *)result;
}