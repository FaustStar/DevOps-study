#!/bin/bash

service nginx restart
gcc -Wall -Werror -Wextra ./app.c -lfcgi -o server.fcgi
spawn-fcgi -p 8080 -n server.fcgi