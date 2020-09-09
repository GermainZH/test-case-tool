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
timeLimit=1

#Validate arguments given
if [ $# != 1 ]
then 
	echo -e "${magenta}[+] Usage incorrect"
	echo -e "${magenta}   Format: $0 *.cpp"
	exit 1;
fi

#Header output
baseName="`basename $1 .cpp`" #base filename
echo -e "${magenta}-----------------------------------------------------"
echo -e "      ${magenta}+===---${cyan}Problem Name: $baseName${magenta}---===+"
echo -e "      ${magenta}+===---${cyan}Time Limit: $timeLimit sec${magenta}---===+"
echo -e "${magenta}-----------------------------------------------------"

#Check filetype
if [ "${1##*.}" == 'cpp' ]
then
	echo -e "${cyan}[+] Compiling $1 with $cpp_flags"
else
	echo -e "${magenta}[+] *.cpp file not found"
	exit 2;
fi

#Compile
echo "$cpp_flags $1 2> feedback" | sh

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
	timeout ${timeLimit}s ./a.out < ${i} > r.out
	exitCode=$?
	if [ $exitCode == 124 ]
	then
		echo -e "${white}Checking ${i%.in}:   ${red}[TLE][❌] Time Limit Exceeded $timeLimit seconds"
	elif [ $exitCode != 0 ]
	then
		#if [ $exitCode == 139 ]
		#then
		#	echo -e "${red}[RTE][${1%.in}] Attempt to access memory out-of-bounds"
		#fi
		echo -e "${white}Checking ${i%.in}:   ${red}[RTE][❌] Runtime Error"
	else
		sdiff -w55 --strip-trailing-cr ${i%.in}.out r.out > r.check
		if [ $? != 0 ]
		then
			echo -e "${white}Checking ${i%.in}:   ${red}[WA][❌] Wrong Answer"
			echo -e "${red}-----------------------------------------------------"
			cat r.check
			echo -e "${red}-----------------------------------------------------"
		else
			acceptedCount=$((acceptedCount+1))
			echo -e "${white}Checking ${i%.in}:   ${green}[AC][✔ ] Accepted"
		fi
	fi
done

echo -e
echo -e "${white}Accepted $acceptedCount / $totalCount"
