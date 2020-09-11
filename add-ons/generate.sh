#!/bin/bash

if [ $# != 3 ]
then 
	echo "[+] Usage incorrect"
	echo "   Format: 1. $0 2. starting case 3. number of cases 4. baseName"
	exit 1;
fi


for((i = $1; i <= $1+$2; ++i)); do
	./caseFormat $i > "$3.$i.in"
	./brute < "$3.$i.in"  > "$3.$i.out"
done
