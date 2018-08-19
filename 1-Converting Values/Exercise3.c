/*****************************************************************************\
* Programming Assignment 1 COMP 3350  
* Exercise3.c                                           *
* Author: Sloan Kiechel                                                          *
* Date  : May 23, 2018         
gcc Exercise3.c -o Exercise3                                          *
\*****************************************************************************/

#include <stdio.h>
#include <stdlib.h>

/*****************************************************************************\
*                               Function prototypes                           *
\*****************************************************************************/
char *integerToString(int num);

/*****************************************************************************\
* function: main()                                                            *
* usage:    command line with no parameter - main tries 3 fi=unctions         *
*******************************************************************************
* Inputs: ANSI flat C NO command line parameters                              *
* Output: None                                                                *
*                                                                             *
\*****************************************************************************/
int main() {
	//Get integer
	int input; //What user inputs
	char* binary; //Binary representation of input
	printf("Enter a positive integer (between 0 and (2^32) - 1): ");
	//scanf will return 1 if successful, 0 if not.
	int errorCheck = scanf("%d", &input);
	if (errorCheck == 0) {
		printf("Invalid input\n");
	}
	else {
		if (input >= 0) {
			binary = integerToString(input);
			printf("The decimal number %d is equivalent to the binary number %s\n", input, binary);
		}
		else {
			printf("Number inputted too small.\n");
		}
	}
}

/***********************************************************************\
* Input : integer number n                                              *
* Output: string s of characters representing n in binary               * 
* Function: returns a string s                                          *                                              
\***********************************************************************/
char* integerToString(int num){
	int value = num;
	char* stringReverse;
	char* string;
	stringReverse = malloc(33);
	string = malloc(33); // 33 = 32+1 as string of 32 charcaters + null characters at the end
	//If value is 0, it is 0 in binary.
	if (value == 0) {
		string[0] = '0';
		string[1] = '\0'; //End string
		return(string);
	}
	//Convert to binary and save in string
	int i = 0;
	while (value != 0) {
		if (value % 2 == 0) {
			stringReverse[i] = '0';
		}
		else { //If it's not 0, it's 1.
			stringReverse[i] = '1';
		}
		i++; //Increment to next spot in string
		value = value/2; //Half value.
	}
	string[i] = '\0';
	int length = i-1;
	//stringReverse is backwards, this flips it to the correct binary representation.
	for (int j = 0; j <= length; j++) {
		string[j] = stringReverse[length-j];
	}
	return(string);
}