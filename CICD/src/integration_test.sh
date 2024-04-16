#!/bin/bash

cd ./src/cat/ && make test > cat.txt
res_cat=$(grep "Number of failed tests:" cat.txt)
cat cat.txt
rm cat.txt

cd ../grep/ && make test > grep.txt
res_grep=$(grep "Number of failed tests:" grep.txt)
cat grep.txt
rm grep.txt

if [[ "$res_cat" = "Number of failed tests: 0" && "$res_grep" = "Number of failed tests: 0" ]]; then
    echo "Integration tests passed"
else
    echo "Integration tests failed"
    exit 1
fi