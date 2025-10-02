CFLAGS = -Wall -Werror -Wextra -std=c11 -pedantic -g

all: s21_grep
	
s21_grep: s21_grep.c
	clang-format -i s21_grep.c
	clang-format -i s21_grep.h
	gcc $(CFLAGS) s21_grep.c s21_grep.h -o s21_grep

test:
	bash testgrep.sh

clean:
	clear
rebuild: clean all

