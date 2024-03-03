#!/usr/bin/env sh

pyenv install -l | grep -E "^  3\.([89]|1[012])\." | awk -F. '{if ($3 > my_arr[$2]){my_arr[$2] = $3}} END{for (key in my_arr) {print key ": " my_arr[key]}}'
