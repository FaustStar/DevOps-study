#!/bin/bash

user_deploy=root
host_deploy=192.168.1.52
dir_deploy=/usr/local/bin

scp -o 'StrictHostKeyChecking no' ./src/cat/s21_cat $user_deploy@$host_deploy:$dir_deploy
if [ $? -ne 0 ]; then
    echo "Copying s21_cat file failed"
    exit 1
fi

scp -o 'StrictHostKeyChecking no' ./src/grep/s21_grep $user_deploy@$host_deploy:$dir_deploy
if [ $? -ne 0 ]; then
    echo "Copying s21_grep file failed"
    exit 1
fi