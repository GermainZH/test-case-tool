#include <bits/stdc++.h>

using namespace std;

int randInt(int low,int high){
	return low+rand()%(high-low+1);
}

char randChar(){
	string chars="abcdefghijklmnopqrstuvwxyz";
	return chars.at(randInt(0,chars.size()-1));
}

int main(int argc, char* argv[]){//1.number of arguments, 2.number of file cases
	srand(atoi(argv[1]));//generate seed for different random values

	//Generate random integer
	//cout<<randInt(0,100);
	
	//Generate random char
	//cout<<randChar();	
	
	//Generate random integer n with n integers
	//int n= randInt(0,100);
	//cout<<n<<'\n';
	//for(int i=0; i<n;++i){
	//	cout<<randInt(0,100)<<' ';
	//}
	
	//Generate random integer n with n integers strictly increasing
	//int n= randInt(0,100);
	//cout<<n<<'\n';
	//int t=0;//min
	//for(int i=0; i<n;++i){
	//	t=randInt(t,100);
	//	cout<<t<<' ';
	//}

	//Generate random integer n with n integers strictly decreasing
	//int n= randInt(0,100);
	//cout<<n<<'\n';
	//int t=100;//max
	//for(int i=0; i<n;++i){
	//	t=randInt(0,t);
	//	cout<<t<<' ';
	//}

	//Generate random integer n with c chars
	//int n= randInt(0,100);
	//cout<<n<<'\n';
	//for(int i=0; i<n;++i){
	//	cout<<randChar()<<' ';
	//}	
	
	//Generate random integer n with n*n matrix of int
	//int n= randInt(0,100);
	//cout<<n<<'\n';
	//for(int i=0; i<n;++i){
	//	for(int y=0; y<n;++y){
	//		cout<<randInt(0,100)<<' ';
	//	}
	//	cout<<'\n';
	//}	
	
	//Generate random integer n with n*n matrix of chars
	//int n= randInt(0,100);
	//cout<<n<<'\n';
	//for(int i=0; i<n;++i){
	//	for(int y=0; y<n;++y){
	//		cout<<randChar()<<' ';
	//	}
	//	cout<<'\n';
	//}	
	
	//Generate random integer n and m with n*m matrix of int
	//int n= randInt(0,100);
	//int m= randInt(0,100);
	//cout<<n<<' '<<m<<'\n';
	//for(int i=0; i<n;++i){
	//	for(int y=0; y<m;++y){
	//		cout<<randInt(0,100)<<' ';
	//	}
	//	cout<<'\n';
	//}
	
	//Generate random integer n and m with n*m matrix of chars
	//int n= randInt(0,100);
	//int m= randInt(0,100);
	//cout<<n<<' '<<m<<'\n';
	//for(int i=0; i<n;++i){
	//	for(int y=0; y<m;++y){
	//		cout<<randChar()<<' ';
	//	}
	//	cout<<'\n';
	//}
	
}
