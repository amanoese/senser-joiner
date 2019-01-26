#!/bin/bash

temp=`mktemp`

for x in "$@"
do
  echo "$x" >> temp
done

cat temp |
  xargs -L1 -i sh -c 'cat {} | head -1 |sed "s/[^0-9]//g"' |
  sed -r -e 's/(....).*/\1/' -e 's/^$/0/' |
  xargs -L3 | tr ' ' \\t | xargs -n3 |
  sed -r 's/^0+//' |awk '{min=10000;for(n=1;n<NF;n+=1){if($n<min){min=$n}};print min}'

rm temp
