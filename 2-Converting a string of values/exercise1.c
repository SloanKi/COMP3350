/*****************************************************************************\
* Module 2: Exercise 1                                                        *
* Exercise1.c                                                                 *
* Author: Sloan Kiechel                                                       *
* Date  : May 30, 2018                                                        *
* gcc Exercise1.c -o Exercise1                                                *                             *
\*****************************************************************************/

/*****************************************************************************\
*                             Global system headers                           *
\*****************************************************************************/
#include <stdio.h>
#include <stdlib.h>

/*****************************************************************************\
*                               Function prototypes                           *
\*****************************************************************************/
unsigned int binaryDigit2Value(char input);
unsigned int binaryString2Value(char arr[]);

/*****************************************************************************\
* function: main()                                                            *
* usage:    command line with no parameter - main tries 3 functions           *
*******************************************************************************
* Inputs: ANSI flat C NO command line parameters                              *
* Output: None                                                                *
\*****************************************************************************/
int main() {
	char str[17];	//16 binary digits + 1 null = 17
	//Get binary integer
	printf("Enter a string representing a 16-bit binary integer: ");
	scanf("%16s", str);
	//convert
	unsigned int result = binaryString2Value(str);
	//Display
	//-1 means it was not a valid binary integer
	if (result == -1) {
		printf("%s is not a  valid 16-bit binary integer\n", str);
	}
	else {
		printf("The value of binary integer %s is %u\n", str, result);
	}
}

/***********************************************************************\
* Input : binary digit (character)                                      *          
* Output: value of the digit                                            *        
* Function: returns value of binary digit                               *
\***********************************************************************/
unsigned int binaryDigit2Value(char input){
	unsigned int value;
	//Convert values
	if (input == '0') {
		value = 0;
	}
	else if (input == '1') {
		value = 1;
	}
	else { //If not a binary digit, return -1.
		value = -1;
	}
	return(value);
}

/***********************************************************************\
* Input : binary string (16 characters)                                *          
* Output: value of the 16 bit binary integer                           *        
* Function: returns value of the 16 bit binary integer                 *
\***********************************************************************/
unsigned int binaryString2Value(char arr[]) {
	//Start at least significant digit
	unsigned int totalValue = 0;
	unsigned int singleValue;
	unsigned int n = 0; //Keep track of start position
	//empty string
	if (arr[0] == '\0') {
		return -1;
	}
	//Finds start position (so if less than 16 digits are entered, it will still
	//compute the value.)
	while (arr[n] != '\0') {
		n++;
	}
	//Starting at start position, calculate value
	for (int i = n-1; i >= 0; i--) {
		singleValue = binaryDigit2Value(arr[i]);
		//If -1, is not binary digit. Return -1 to allow main to output error.
		if (singleValue == -1) {
			return -1;
		}
		else {
			totalValue += singleValue * (1 << ((n-1) - i)); //2^((n-1) - i)
		}
	}
	return totalValue;
}