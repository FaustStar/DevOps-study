TARGET = s21_grep
CFLAGS = -Wall -Werror -Wextra -std=c11

CLANG_PATH = ../../materials/linters/
CLANG_COPY = cp $(CLANG_PATH).clang-format .clang-format

OS = $(shell uname)

ifeq ($(OS), Darwin)
	SYSTEM = mac
else
	SYSTEM = linux
endif

.PHONY: all clean rebuild test

all: $(TARGET)

clean:
	rm -rf $(TARGET) *.o ../common/*.o .clang-format

$(TARGET): s21_grep.o ../common/common.o
	gcc $(CFLAGS) s21_grep.o ../common/common.o -o $(TARGET)

s21_grep.o: s21_grep.c s21_grep.h
	gcc $(CFLAGS) -c s21_grep.c

../commom/commom.o: ../common/common.c ../common/common.h
	gcc $(CFLAGS) -c ../common/common.c

rebuild:
	$(MAKE) clean
	$(MAKE) all

test:
	chmod +x ./test/grep_test_$(SYSTEM).sh
	./test/grep_test_$(SYSTEM).sh

clang:
	$(CLANG_COPY) && clang-format -n *.c *.h

verter:
	cd ../../materials/build && sh run.sh
	cd ../../..