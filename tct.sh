#Colours
red='\u001b[1;91m'
green='\u001b[1;92m'
cyan='\u001b[1;96m'
magenta='\u001b[1;95m'
white='\u001b[1;97m'

#Exit script cleanly
trap "{ rm -f feedback a.out r.out r.check; }" SIGTERM SIGQUIT SIGINT EXIT

#Edit
cpp_flags="g++ -std=c++17 -O2 -w -lm"
c_flags="gcc -O2 -w -lm"

timeLimit=1

#Validate arguments given
if [ $# != 1 ]
then 
	echo -e "${magenta}[+] Usage incorrect"
	echo -e "${magenta}   Format: $0 *.cpp"
	exit 1;
fi

#Check filetype
if [ "${1##*.}" == 'cpp' ]
then
	flags=$cpp_flags
	baseName="`basename $1 .cpp`" #base filename
elif [ "${1##*.}" == 'c' ]
then
	flags=$c_flags
	baseName="`basename $1 .c`" #base filename
else
	echo -e "${magenta}[+] Filetype invalid"
	echo -e "${magenta}   Make sure file is of type '.c' or '.cpp'" 
	exit 2;
fi

#Header output
echo -e "${magenta}-----------------------------------------------------"
echo -e "      ${magenta}+===---${cyan}Problem Name: $baseName${magenta}---===+"
echo -e "      ${magenta}+===---${cyan}Time Limit: $timeLimit sec${magenta}---===+"
echo -e "${magenta}-----------------------------------------------------"


#Compile
echo -e "${cyan}[+] Compiling $1 with $flags"
echo "$flags $1 2> feedback" | sh

result=$?
if [ $result -ne 0 ]
then
	echo -e "${magenta}[+] Compile Error"
	exit 1;
fi

#Run for all files of format baseName.*.in and check baseName.*.out
echo -e "${cyan}[+] Running Test Cases"

for i in $baseName.*.in
do
	if [ "${i}" == "$baseName.*.in" ]
	then
		echo -e "${magenta}[+] No input files located"
		exit 1;
	fi
	totalCount=$((totalCount+1))
	start=`date +%s%N`
	timeout ${timeLimit}s ./a.out < ${i} > r.out
	end=`date +%s%N`
	time=`awk "BEGIN {x=$start; y=$end; z=(y-x)/1000000000; print z}"`
	exitCode=$?
	if [ $exitCode == 124 ]
	then
		echo -e "${white}Checking ${i%.in}:   ${red}[TLE][❌][$(($((end-start))/1000000)) ms] Time Limit Exceeded $timeLimit seconds"
	elif [ $exitCode != 0 ]
	then
		#if [ $exitCode == 139 ]
		#then
		#	echo -e "${red}[RTE][${1%.in}] Attempt to access memory out-of-bounds"
		#fi
		echo -e "${white}Checking ${i%.in}:   ${red}[RTE][❌][$time ms] Runtime Error"
	else
		sdiff -w55 --strip-trailing-cr ${i%.in}.out r.out > r.check
		if [ $? != 0 ]
		then
			echo -e "${white}Checking ${i%.in}:   ${red}[WA][❌][$time ms] Wrong Answer"
			echo -e "${cyan}[Expected Output]               [Generated Output]"
			echo -e "${red}-----------------------------------------------------"
			cat r.check
			echo -e "${red}-----------------------------------------------------"
		else
			acceptedCount=$((acceptedCount+1))
			echo -e "${white}Checking ${i%.in}:   ${green}[AC][✔ ][$time ms] Accepted"
		fi
	fi
done

echo -e
echo -e "${white}Accepted $acceptedCount / $totalCount"
