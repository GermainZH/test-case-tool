# test-case-tool
Shell-script that automates the process of checking solutions. 

Test-case-tool or Tct compiles and runs a program against multiple test-cases and provides feedback for each case. 

Tct is still in development and there will be many new changes and additions in the future.

## Demo
In order to use the grader, run the shell script file and pass an ".cpp" file.

```bash
$ ./tcc.sh filename.cpp
```

![](images/test-case-tester-snapshot-1.0.3.PNG)

(example files used in this snapshot can be found in /Demo)

### Usage details
- The program must use standard input and output
- Input and expected output files must be of the format "filename.#.in" & "filename.#.out"
  - for an file named "test.cpp" the input and output files would be:
    - test.1.in, test.2.in... test.n.in
    - test.1.out, test.2.out... test.n.out
- The number of input files must match the number of expected output files
- The tct.sh file must be placed in the same directory as the source file.
- (Java users only) class must be called Main (refer to demo/fizzbuzz.java for a file format example)

## Supported Languages
Test-case-tool has support for C++, C and Java.

## What to expect in the future
As of now, Tct should not be used as a standalone tool for testing your programs. Although it can detect TLE errors and check outputs with accuracy, some runtimes errors manage to slip by without being detected. This tool should only be used once you have confirmed your program will run smoothly, at which point the tool can be executed to grade all test-cases.

## Extras
Here are some add-ons I use along with this script.

### /add-ons/cp.sh/ 
a simple script to make an directory containing tct.sh (I use this to keep my cp directory from getting cluttered with test-cases)

### /add-ons/generate.sh/
script to generate testcases using a brute solution and place them in files to be checked by Tct.
