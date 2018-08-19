/*****************************************************************************\
* Module 2: Exercise 3                                                        *
* Exercise3.c                                                                 *
* Author: Sloan Kiechel                                                       *
* Date  : May 30, 2018                                                        *
* gcc Exercise3.c -o Exercise3                                                *                              *
\*****************************************************************************/

/*****************************************************************************\
*                             Global system headers                           *
\*****************************************************************************/
#include <stdio.h>
#include <stdlib.h>

/*****************************************************************************\
*                               Function prototypes                           *
\*****************************************************************************/
char *integerToString(int num);

/*****************************************************************************\
* function: main()                                                            *
* usage:    command line with no parameter - main tries 3 functions           *
*******************************************************************************
* Inputs: ANSI flat C NO command line parameters                              *
* Output: None                                                                *
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
	char* result; //Binary result 
	result = malloc(33); //33 = 32+1 as string of 32 characters + null characters at the end
	//Convert
	for (int i = 31; i >= 0 ; i--) {
		result[i] = (num & 1) + 48;
		//Right shift num by 1
		num >>= 1;
	}
	result[32] = '\0'; //Null character to end string
	return result;
}