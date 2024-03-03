#!/usr/bin/env bash

# python3 -m pip list --outdated | awk 'NR > 2 {print($2)}'

mapfile outdated < <(awk 'NR > 2 {if ($4 != "sdist") print($1)}' pipList.txt)

for item in "${outdated[@]}"; do
	echo "$item"
done
