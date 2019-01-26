#!/bin/bash

temp=`mktemp`

for x in "$@"
do
  echo "$x" >> temp
done

cat temp | xargs -L1 -i sh -c 'cat {} | head -1 |sed "s/[^0-9]//g"' | sed -r 's/(....).*/\1/' | cat
rm temp
