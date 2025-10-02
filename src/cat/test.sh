File_1="file.txt"
File_2="file_3.txt"

CAT_RES="cat_results.tst"
S21_RES="s21_cat_results.tst"

CLEAR="rm -rf *.tst"

FILES=("$File_1" "$File_2")

$CLEAR

for F in "${FILES[@]}"; do
    cat -e $F > $CAT_RES
    ./s21_cat -e $F > $S21_RES

    if diff -q $CAT_RES $S21_RES; then
        echo "Test cat -e for $F SUCCESS" 
    else 
        echo "Test cat -e for $F FAIL"
    fi

done

$CLEAR

for F in "${FILES[@]}"; do
    cat -t $F > $CAT_RES
    ./s21_cat -t $F > $S21_RES

    if diff -q $CAT_RES $S21_RES; then
        echo "Test cat -t for $F SUCCESS" 
    else 
        echo "Test cat -t for $F FAIL"
    fi

done

$CLEAR

for F in "${FILES[@]}"; do
    cat -v $F > $CAT_RES
    ./s21_cat -v $F > $S21_RES

    if diff -q $CAT_RES $S21_RES; then
        echo "Test cat -v for $F SUCCESS" 
    else 
        echo "Test cat -v for $F FAIL"
    fi

done

$CLEAR

for F in "${FILES[@]}"; do
    cat $F > $CAT_RES
    ./s21_cat $F > $S21_RES

    if diff -q $CAT_RES $S21_RES; then
        echo "Test cat read file $F SUCCESS" 
    else 
        echo "Test cat read file $F FAIL"
    fi

done

$CLEAR

for F in "${FILES[@]}"; do
    cat -b $F > $CAT_RES
    ./s21_cat -b $F > $S21_RES

    if diff -q $CAT_RES $S21_RES; then
        echo "Test cat -b for $F SUCCESS" 
    else 
        echo "Test cat -b for $F FAIL"
    fi

done

$CLEAR

FILES=("$File_1" "$File_2")

for F in "${FILES[@]}"; do
    cat $F -n > $CAT_RES
    ./s21_cat $F -n > $S21_RES

    if diff -q $CAT_RES $S21_RES; then
        echo "Test cat -n flag after the filename for $F SUCCESS" 
    else 
        echo "Test cat -n flag after the filename for $F FAIL"
    fi

done

$CLEAR

for F in "${FILES[@]}"; do
    cat -n $F > $CAT_RES
    ./s21_cat -n $F > $S21_RES

    if diff -q $CAT_RES $S21_RES; then
        echo "Test cat -n for $F SUCCESS" 
    else 
        echo "Test cat -n for $F FAIL"
    fi

done

$CLEAR

for F in "${FILES[@]}"; do
    cat -s $F > $CAT_RES
    ./s21_cat -s $F > $S21_RES

    if diff -q $CAT_RES $S21_RES; then
        echo "Test cat -s for $F SUCCESS" 
    else 
        echo "Test cat -s for $F FAIL"
    fi

done

$CLEAR
