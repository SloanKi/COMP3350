
/*****************************************************************************\
* Programming Assignment 1 COMP 3350                                          *
* Exercise1.c                                                                 *
* Author: Sloan Kiechel                                                       *
* Date  : May 23, 2018                                                        *
gcc Exercise1.c -o Exercise1                                                  *
\*****************************************************************************/

#include <stdio.h>
#include <stdlib.h>

/*****************************************************************************\
*                               Function prototypes                           *
\*****************************************************************************/
unsigned int binaryDigit2Value(char input);

/*****************************************************************************\
* function: main()                                                            *
* usage:    command line with no parameter - main tries 3 fi=unctions         *
*******************************************************************************
* Inputs: ANSI flat C NO command line parameters                              *
* Output: None                                                                *
*                                                                             *
\*****************************************************************************/
int main() {
	char c;
	//Get character
	printf("Enter a character that represents a binary digit: ");
	c = getchar();
	//Convert
	unsigned int value = binaryDigit2Value(c);
	//Display
	if (value == -1) { //Not valid bit
		printf("The character %c is invalid: %c is not a bit.\n", c, c);
	}
	else { //valid bit
		printf("The value of bit %c is %u\n", c, value);
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