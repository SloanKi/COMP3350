
/*****************************************************************************\
* Programming Assignment 1 COMP 3350                                          *
* Exercise2.c                                                                 *
* Author: Sloan Kiechel                                                       *
* Date  : May 23, 2018                                                        *
gcc Exercise2.c -o Exercise2                                                  *
\*****************************************************************************/

#include <stdio.h>
#include <stdlib.h>

/*****************************************************************************\
*                               Function prototypes                           *
\*****************************************************************************/
unsigned int hexaDigit2Value(char input);

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
	printf("Enter a character that represents a hexadecimal digit: ");
	c = getchar();
	//Convert
	unsigned int value = hexaDigit2Value(c);
	//Display
	if (value == -1) { //Not valid bit
		printf("The character %c is invalid: %c is not a hexadecimal digit.\n", c, c);
	}
	else { //valid bit
		printf("The value of the hexadecimal digit %c is %u\n", c, value);
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
	switch (input) {
		case '0': 
			value = 0;
			break;
		case '1': 
			value = 1;
			break;
		case '2': 
			value = 2;
			break;
		case '3': 
			value = 3;
			break;
		case '4': 
			value = 4;
			break;
		case '5': 
			value = 5;
			break;
		case '6': 
			value = 6;
			break;
		case '7': 
			value = 7;
			break;
		case '8': 
			value = 8;
			break;
		case '9': 
			value = 9;
			break;
		case 'A': 
			value = 10;
			break;
		case 'B': 
			value = 11;
			break;
		case 'C': 
			value = 12;
			break;
		case 'D': 
			value = 13;
			break;
		case 'E': 
			value = 14;
			break;
		case 'F': 
			value = 15;
			break;
		default: //Not hexadecimal digit, return -1
			value = -1;
	}
	return(value);
}