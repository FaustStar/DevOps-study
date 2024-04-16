#!/bin/bash

cp ./materials/linters/.clang-format .clang-format
clang-format -n ./src/*/*.[ch] 2> style.txt
rm .clang-format

res=$(wc -l style.txt)
cat style.txt
rm style.txt

if [ "$res" = "0 style.txt" ]; then
    echo "Style test passed"
else
    echo "Style test failed"
    exit 1
fi