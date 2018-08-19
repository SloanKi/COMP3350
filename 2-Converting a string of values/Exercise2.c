/*****************************************************************************\
* Module 2: Exercise 2                                                        *
* Exercise2.c                                                                 *
* Author: Sloan Kiechel                                                       *
* Date  : May 30, 2018                                                        *
* gcc Exercise2.c -o Exercise2                                                *                               *
\*****************************************************************************/

/*****************************************************************************\
*                             Global system headers                           *
\*****************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h> //isalpha() and isdigit()

/*****************************************************************************\
*                               Function prototypes                           *
\*****************************************************************************/
unsigned int hexaDigit2Value(char input);
unsigned int hexaString2Value(char arr[]);
unsigned int raiseToPower(unsigned int num, unsigned int power);

/*****************************************************************************\
* function: main()                                                            *
* usage:    command line with no parameter - main tries 3 functions           *
*******************************************************************************
* Inputs: ANSI flat C NO command line parameters                              *
* Output: None                                                                *
\*****************************************************************************/
int main() {
	char str[5];	//4 hexadecimal digits + 1 null = 5
	//Get hexadecimal number
	printf("Enter a string representing a 4 digit hexadecimal number: ");
	scanf("%4s", str);
	//convert
	unsigned int result = hexaString2Value(str);
	//Display
	//-1 means it was not a valid binary integer
	if (result == -1) {
		printf("%s is not a  valid 4 digit hexadecimal number\n", str);
	}
	else {
		printf("The value of hexadecimal number %s is %u\n", str, result);
	}
}

/***********************************************************************\
* Input : hexadecimal digit (character)                                 *
* Output: value of the digit                                            *           
* Function: returns value of hexadecimal digit                               *                                               
\***********************************************************************/
unsigned int hexaDigit2Value(char input){
	unsigned int value;
	//Convert values
	//If input is 0-9
	if (isdigit(input)) {
		value = input - '0';
	}
	//If input is letter
	else if (isalpha(input)) {
		value = input - 'A' + 10;
	}
	//Letter bigger than F returns a value bigger than 15.
	if (value > 15) {
		return - 1;
	}
	//if less than = to 15, return the value.
	return(value);
}

/***********************************************************************\
* Input : hexadecimal string (4 characters)                            *          
* Output: value of the 4 digit hexadecimal number                      *        
* Function: returns value of the hexadecimal number                    *
\***********************************************************************/
unsigned int hexaString2Value(char arr[]) {
	//Start at least significant digit
	unsigned int totalValue = 0;
	unsigned int singleValue;
	unsigned int n = 0; //Keep track of start position
	//empty string
	if (arr[0] == '\0') {
		return -1;
	}
	//Finds start position (so if less than 4 digits are entered, it will still
	//compute the value.)
	while (arr[n] != '\0') {
		n++;
	}
	//Starting at start position, calculate value
	for (int i = n-1; i >= 0; i--) {
		singleValue = hexaDigit2Value(arr[i]);
		//If -1, is not hexadecimal digit. Return -1 to allow main to output error.
		if (singleValue == -1) {
			return -1;
		}
		else {
			totalValue += singleValue * raiseToPower(16, (n - 1 - i)); //16 ^ (n-1-i)
		}
	}
	return totalValue;
}

/***********************************************************************\
* Input : number and power to raise it to                              *          
* Output: value of the number raised to the power                      *        
* Function: returns value of the number raised to the power            *
\***********************************************************************/
unsigned int raiseToPower(unsigned int num, unsigned int power) {
	int result = 1;
	for (int j = 0; j < power; j ++) {
		result *= num;
	}
	return result;
}