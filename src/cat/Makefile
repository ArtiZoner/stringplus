CFLAGS = -Wall -Werror -Wextra -std=c11 -pedantic

all: s21_cat
	
s21_cat: s21_cat.c
	clang-format -i s21_cat.c
	gcc $(CFLAGS) s21_cat.c s21_cat.h -o s21_cat

test:
	bash test.sh

clean:
	rm -rf *.o
rebuild: clean all

