F1="file_2.txt"
F2="file.txt"

PATTERN=однако
PATTERN2=практика

GREP_RES="grep_result.tst"
S21_RES="s21_grep_result.tst"

CLEAR="rm -rf *.tst"
SLEEP="sleep 0.5"

$SLEEP
$CLEAR

FILES=("$F1" "$F2")

for F in "${FILES[@]}"; do
    grep -e $PATTERN $F > $GREP_RES
    ./s21_grep -e $PATTERN $F > $S21_RES

    if diff -q $GREP_RES $S21_RES; then
        echo "Test grep -e for $F SUCCESS" 
    else 
        echo "Test grep -e for $F FAIL"
    fi

done

$SLEEP
$CLEAR

for F in "${FILES[@]}"; do
    grep -i $PATTERN2 $F > $GREP_RES
    ./s21_grep -i $PATTERN2 $F > $S21_RES

    if diff -q $GREP_RES $S21_RES; then
        echo "Test grep -i for $F SUCCESS" 
    else 
        echo "Test grep -i for $F FAIL"
    fi

done

$SLEEP
$CLEAR

for F in "${FILES[@]}"; do
    grep -c $PATTERN $F > $GREP_RES
    ./s21_grep -c $PATTERN $F > $S21_RES

    if diff -q $GREP_RES $S21_RES; then
        echo "Test grep -c for $F SUCCESS" 
    else 
        echo "Test grep -c for $F FAIL"
    fi

done

$SLEEP
$CLEAR

    grep -l $PATTERN *.txt > $GREP_RES
    ./s21_grep -l $PATTERN *.txt > $S21_RES

    if diff -q $GREP_RES $S21_RES; then
        echo "Test grep -l for $PATTERN SUCCESS" 
    else 
        echo "Test grep -l for $PATTERN FAIL"
    fi


$SLEEP
$CLEAR

for F in "${FILES[@]}"; do
    grep -n $PATTERN $F > $GREP_RES
    ./s21_grep -n $PATTERN $F > $S21_RES

    if diff -q $GREP_RES $S21_RES; then
        echo "Test grep -n for $F SUCCESS" 
    else 
        echo "Test grep -n for $F FAIL"
    fi

done

$SLEEP
$CLEAR

for F in "${FILES[@]}"; do
    grep -h $PATTERN $F > $GREP_RES
    ./s21_grep -h $PATTERN $F > $S21_RES

    if diff -q $GREP_RES $S21_RES; then
        echo "Test grep -h for $F SUCCESS" 
    else 
        echo "Test grep -h for $F FAIL"
    fi

done

$SLEEP
$CLEAR

for F in "${FILES[@]}"; do
    grep -v $PATTERN $F > $GREP_RES
    ./s21_grep -v $PATTERN $F > $S21_RES

    if diff -q $GREP_RES $S21_RES; then
        echo "Test grep -v for $F SUCCESS" 
    else 
        echo "Test grep -v for $F FAIL"
    fi

done

$CLEAR