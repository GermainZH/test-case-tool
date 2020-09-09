#COLOURS
red='\u001b[31m'
green='\u001b[32m'
cyan='\u001b[36m'
magenta='\u001b[35m'

#Exit script cleanly
trap "{ rm -f feedback a.out r.out r.check; }" SIGTERM SIGQUIT SIGINT EXIT

#VARS
cppFile="$1"
baseName="`basename $1 .cpp`"
inputFile="#.in"
expectedFile="#.out"
cpp_flags="g++ -std=c++17 -O2 -w -lm"
timeLimit=1

#Validate arguments given
if [ $# -eq 1 ]
then 
	echo -e "${cyan}[+] Usage correct"
else
	echo -e "${magenta}[+] Usage incorrect"
	echo -e "${magenta}   Format: $0 *.cpp"
fi

#Check filetype
if [ "${cppFile##*.}" == 'cpp' ]
then
	echo -e "${cyan}[+] *.cpp file confirmed"
else
	echo -e "${magenta}[+] *.cpp file not found"
	exit 1;
fi

#Compile
echo -e "${cyan}[+] Compiling $cppFile"
echo "$cpp_flags $1 2> feedback" | sh

result=$?
if [ $result -ne 0 ]
then
	echo -e "${magenta}<<Compile Error>>"
else
	echo -e "${cyan}<<Compile Successful>>"
fi

#Run for all files of format baseName.*.in and check baseName.*.out
for i in $baseName.*.in
do
	if [ "${i}" == "$baseName.*.in" ]
	then
		echo -e "${magenta}[+] No input files located"
		exit 1;
	fi
	timeout ${timeLimit}s ./a.out < ${i} > r.out
	exitCode=$?
	if [ $exitCode == 124 ]
	then
		echo -e "${red}[TLE][${1%.in}] Time Limit Exceeded $timeLimit seconds"
	elif [ $exitCode != 0 ]
	then
		#if [ $exitCode == 139 ]
		#then
		#	echo -e "${red}[RTE][${1%.in}] Attempt to access memory out-of-bounds"
		#fi
		echo -e "${red}[RTE][${1%.in}] Runtime Error"
	else
		echo "+===---[${i%.in}] Running Test Case---===+"
		colordiff --strip-trailing-cr ${i%.in}.out r.out > r.check
		if [ $? != 0 ]
		then
			echo -e "${red}[WA] Wrong Answer"
			cat r.check
		else
			echo -e "${green}[AC] Accepted"
		fi
	fi
done
