#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m' 
YELLOW='\033[0;33m' 
NC='\033[0m'

START_DIR="$(pwd)"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TEST_FILE="s21_grep.c"
PATTERN_FILE="patterns.txt"
TEMP_FILE="temp_test.txt"

echo -e "hello world\nthis is a test\nanother line\nHELLO again\n123 hello 456" > $SCRIPT_DIR/$TEMP_FILE
echo -e "hello\nworld" > $SCRIPT_DIR/$PATTERN_FILE

format() {
    CLANG_SOURCE="$(realpath "$SCRIPT_DIR/../../materials")/linters/.clang-format"

    if [ ! -f "$CLANG_SOURCE" ]; then
        echo "Ошибка: Файл $CLANG_SOURCE не найден!" >&2
        exit 1
    fi

    cp "$CLANG_SOURCE" "$START_DIR"

    clang-format -i $SCRIPT_DIR/$TEST_FILE $SCRIPT_DIR/s21_grep.h $SCRIPT_DIR/../common/*.*
}

delete_colors() {
    sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g"
}

compare_output() {
    local command1="$1"
    local command2="$2"
    local test_name="$3"
    
    eval "$command1" | delete_colors > $SCRIPT_DIR/out1.txt
    eval "$command2" | delete_colors > $SCRIPT_DIR/out2.txt
    
    if diff -q $SCRIPT_DIR/out1.txt $SCRIPT_DIR/out2.txt > /dev/null; then
        echo -e ${PURPLE}"TEST: ${GREEN}PASS\t${PURPLE}OPTIONS:${NC} $test_name\033[50G${YELLOW}$command1\033[110G$command2${NC}"
    else
        echo -e ${PURPLE}"TEST: ${RED}FAIL\t${PURPLE}OPTIONS:${NC} $test_name\033[50G${YELLOW}$command1\033[110G$command2${NC}"
        echo "Differences:"
        diff $SCRIPT_DIR/out1.txt $SCRIPT_DIR/out2.txt
    fi
}

# format

# echo -e "${PURPLE}Compile...${NC}"
# make -C $SCRIPT_DIR s21_grep

cd $SCRIPT_DIR


echo -e "\n${PURPLE}Starting s21_grep tests...${NC}"

echo -e "${YELLOW}\nBasic tests${NC}"
compare_output "grep hello $TEMP_FILE" "./s21_grep hello $TEMP_FILE" "Basic search"

echo -e "${YELLOW}\nShort option tests${NC}"
compare_output "grep -i HELLO $TEMP_FILE" "./s21_grep -i HELLO $TEMP_FILE" "-i (ignore case)"
compare_output "grep -v hello $TEMP_FILE" "./s21_grep -v hello $TEMP_FILE" "-v (invert match)"
compare_output "grep -c hello $TEMP_FILE" "./s21_grep -c hello $TEMP_FILE" "-c (count)"
compare_output "grep -l hello $TEMP_FILE $TEST_FILE" "./s21_grep -l hello $TEMP_FILE $TEST_FILE" "-l (files with matches)"
compare_output "grep -n hello $TEMP_FILE" "./s21_grep -n hello $TEMP_FILE" "-n (line number)"
compare_output "grep -h hello $TEMP_FILE $TEST_FILE" "./s21_grep -h hello $TEMP_FILE $TEST_FILE" "-h (no filename)"
compare_output "grep -s no_such_file $TEMP_FILE no_file" "./s21_grep -s no_such_file $TEMP_FILE no_file" "-s (suppress errors)"
compare_output "grep -f $PATTERN_FILE $TEMP_FILE" "./s21_grep -f $PATTERN_FILE $TEMP_FILE" "-f (file patterns)"
compare_output "grep -o hello $TEMP_FILE" "./s21_grep -o hello $TEMP_FILE" "-o (only matching)"
compare_output "grep -e hello -e world $TEMP_FILE" "./s21_grep -e hello -e world $TEMP_FILE" "-e (pattern)"

# echo -e "${YELLOW}\nLong option tests${NC}"
# compare_output "grep --ignore-case HELLO $TEMP_FILE" "./s21_grep --ignore-case HELLO $TEMP_FILE" "--ignore-case"
# compare_output "grep --invert-match hello $TEMP_FILE" "./s21_grep --invert-match hello $TEMP_FILE" "--invert-match"
# compare_output "grep --count hello $TEMP_FILE" "./s21_grep --count hello $TEMP_FILE" "--count"
# compare_output "grep --files-with-matches hello $TEMP_FILE $TEST_FILE" "./s21_grep --files-with-matches hello $TEMP_FILE $TEST_FILE" "--files-with-matches"
# compare_output "grep --line-number hello $TEMP_FILE" "./s21_grep --line-number hello $TEMP_FILE" "--line-number"
# compare_output "grep --no-filename hello $TEMP_FILE $TEST_FILE" "./s21_grep --no-filename hello $TEMP_FILE $TEST_FILE" "--no-filename"
# compare_output "grep --no-messages no_such_file $TEMP_FILE no_file" "./s21_grep --no-messages no_such_file $TEMP_FILE no_file" "--no-messages"
# compare_output "grep --file $PATTERN_FILE $TEMP_FILE" "./s21_grep --file $PATTERN_FILE $TEMP_FILE" "--file"
# compare_output "grep --only-matching hello $TEMP_FILE" "./s21_grep --only-matching hello $TEMP_FILE" "--only-matching"

#echo -e "${YELLOW}\nTests with combinations of short options${NC}"
#compare_output "grep -iv hello $TEMP_FILE" "./s21_grep -iv hello $TEMP_FILE" "-i + -v"
#compare_output "grep -in hello $TEMP_FILE" "./s21_grep -in hello $TEMP_FILE" "-i + -n"
#compare_output "grep -cv hello $TEMP_FILE" "./s21_grep -cv hello $TEMP_FILE" "-c + -v"
#compare_output "grep -ho hello $TEMP_FILE $TEST_FILE" "./s21_grep -ho hello $TEMP_FILE $TEST_FILE" "-h + -o"
#compare_output "grep -nf $PATTERN_FILE $TEMP_FILE" "./s21_grep -nf $PATTERN_FILE $TEMP_FILE" "-n + -f"
#compare_output "grep -lv hello $TEMP_FILE" "./s21_grep -lv hello $TEMP_FILE" "-l + -v"
#compare_output "grep -nv hello $TEMP_FILE" "./s21_grep -nv hello $TEMP_FILE" "-n + -v"
#compare_output "grep -e hello -e world -i $TEMP_FILE" "./s21_grep -e hello -e world -i $TEMP_FILE" "-e + -i"
#compare_output "grep -f $PATTERN_FILE -i $TEMP_FILE" "./s21_grep -f $PATTERN_FILE -i $TEMP_FILE" "-f + -i"
#compare_output "grep -f $PATTERN_FILE -v $TEMP_FILE" "./s21_grep -f $PATTERN_FILE -v $TEMP_FILE" "-f + -v"
#compare_output "grep -f $PATTERN_FILE -n $TEMP_FILE" "./s21_grep -f $PATTERN_FILE -n $TEMP_FILE" "-f + -n"
#compare_output "grep -e hello -f $PATTERN_FILE $TEMP_FILE" "./s21_grep -e hello -f $PATTERN_FILE $TEMP_FILE" "-e + -f"
#compare_output "grep -f $PATTERN_FILE -e test $TEMP_FILE" "./s21_grep -f $PATTERN_FILE -e test $TEMP_FILE" "-f + -e"
#compare_output "grep -i -n hello $TEMP_FILE" "./s21_grep -i -n hello $TEMP_FILE" "-i + -n"
#compare_output "grep -v -c hello $TEMP_FILE" "./s21_grep -v -c hello $TEMP_FILE" "-v + -c"
#compare_output "grep -l -h hello $TEMP_FILE $TEST_FILE" "./s21_grep -l -h hello $TEMP_FILE $TEST_FILE" "-l + -h"
#compare_output "grep -o -n hello $TEMP_FILE" "./s21_grep -o -n hello $TEMP_FILE" "-o + -n"

#compare_output "grep -iv HELLO $TEMP_FILE" "./s21_grep -iv HELLO $TEMP_FILE" "-iv"
#compare_output "grep -cv hello $TEMP_FILE" "./s21_grep -cv hello $TEMP_FILE" "-cv"
#compare_output "grep -lv hello $TEMP_FILE $TEST_FILE" "./s21_grep -lv hello $TEMP_FILE $TEST_FILE" "-lv"
#compare_output "grep -nv hello $TEMP_FILE" "./s21_grep -nv hello $TEMP_FILE" "-nv (line number)"
#compare_output "grep -hv hello $TEMP_FILE $TEST_FILE" "./s21_grep -hv hello $TEMP_FILE $TEST_FILE" "-hv"
#compare_output "grep -v -s no_such_file $TEMP_FILE no_file" "./s21_grep -v -s no_such_file $TEMP_FILE no_file" "-v -s"
#compare_output "grep -v -f $PATTERN_FILE $TEMP_FILE" "./s21_grep -v -f $PATTERN_FILE $TEMP_FILE" "-v -f"
##compare_output "grep -ov hello $TEMP_FILE" "./s21_grep -ov hello $TEMP_FILE" "-ov"
#compare_output "grep -v -e hello -e world $TEMP_FILE" "./s21_grep -v -e hello -e world $TEMP_FILE" "-v -e"
#
#compare_output "grep -on hello $TEMP_FILE" "./s21_grep -on hello $TEMP_FILE" "-on"
#compare_output "grep -ol hello $TEMP_FILE" "./s21_grep -ol hello $TEMP_FILE" "-ol"
#compare_output "grep -oc hello $TEMP_FILE" "./s21_grep -oc hello $TEMP_FILE" "-oc"
##compare_output "grep -oi hello $TEMP_FILE" "./s21_grep -oi hello $TEMP_FILE" "-oi"
##compare_output "grep -oh hello $TEMP_FILE" "./s21_grep -oh hello $TEMP_FILE" "-oh"
#
#
#echo -e "${YELLOW}\nTests with multiple options${NC}"
#compare_output "grep -e hello -e world $TEMP_FILE" "./s21_grep -e hello -e world $TEMP_FILE" "Multiple -e"
#compare_output "grep -f $PATTERN_FILE -f $PATTERN_FILE $TEMP_FILE" "./s21_grep -f $PATTERN_FILE -f $PATTERN_FILE $TEMP_FILE" "Multiple -f"
#compare_output "grep -e hello -f $PATTERN_FILE $TEMP_FILE" "./s21_grep -e hello -f $PATTERN_FILE $TEMP_FILE" "-e + -f"
#
#echo -e "${YELLOW}\nTests with combinations of any options${NC}"
#compare_output "grep -i -n -e hello $TEMP_FILE" "./s21_grep -i -n -e hello $TEMP_FILE" "-i + -n + -e"
#compare_output "grep -v -c -f $PATTERN_FILE $TEMP_FILE" "./s21_grep -v -c -f $PATTERN_FILE $TEMP_FILE" "-v + -c + -f"
#compare_output "grep -i -e hello -e WORLD $TEMP_FILE" "./s21_grep -i -e hello -e WORLD $TEMP_FILE" "-i with multiple -e"
#compare_output "grep -v -e hello -e test $TEMP_FILE" "./s21_grep -v -e hello -e test $TEMP_FILE" "-v with multiple -e"
#compare_output "grep -n -e hello -e 123 $TEMP_FILE" "./s21_grep -n -e hello -e 123 $TEMP_FILE" "-n with multiple -e"
#compare_output "grep -i -v -n hello $TEMP_FILE" "./s21_grep -i -v -n hello $TEMP_FILE" "-i + -v + -n"
#compare_output "grep -e hello -e world -i -n $TEMP_FILE" "./s21_grep -e hello -e world -i -n $TEMP_FILE" "Multiple -e + -i + -n"
#compare_output "grep -f $PATTERN_FILE -v -c $TEMP_FILE" "./s21_grep -f $PATTERN_FILE -v -c $TEMP_FILE" "-f + -v + -c"
#compare_output "grep -e hello -o -n $TEMP_FILE" "./s21_grep -e hello -o -n $TEMP_FILE" "-e + -o + -n"
#
##compare_output "grep -ovn hello $TEMP_FILE" "./s21_grep -ovn hello $TEMP_FILE" "-ovn"
#compare_output "grep -ovl hello $TEMP_FILE" "./s21_grep -ovl hello $TEMP_FILE" "-ovl"
#compare_output "grep -ovc hello $TEMP_FILE" "./s21_grep -ovc hello $TEMP_FILE" "-ovc"
##compare_output "grep -ovi hello $TEMP_FILE" "./s21_grep -ovi hello $TEMP_FILE" "-ovi"
##compare_output "grep -ovh hello $TEMP_FILE" "./s21_grep -ovh hello $TEMP_FILE" "-ovh"
#
#echo -e "${PURPLE}\nClean...${NC}"
#rm -f $SCRIPT_DIR/out1.txt $SCRIPT_DIR/out2.txt $SCRIPT_DIR/$TEMP_FILE $SCRIPT_DIR/$PATTERN_FILE $START_DIR/.clang-format
## make -C $SCRIPT_DIR clean 
#
#cd $START_DIR
#
echo -e "${PURPLE}\nTesting completed.${NC}"