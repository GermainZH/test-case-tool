#!/bin/bash

if [ $# != 1 ]
then 
	echo -e "${magenta}[+] Usage incorrect"
	echo -e "${magenta}   Format: $0 name"
	exit 1;
fi

mkdir $1

cp grader.sh $1
cp caseFormat.cpp $1
cp brute.cpp $1
cp generate.sh $1
