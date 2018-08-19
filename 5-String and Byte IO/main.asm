; Module 6 programs
; 6/28/2018 Sloan Kiechel
INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	prompt1 BYTE "Please enter a sentence",0dh,0ah, 0
     prompt2 BYTE "Please enter a character",0dh,0ah, 0
     prompt3 BYTE "Please enter the first sentence",0dh,0ah,0
     prompt4 BYTE "Please enter the second sentence",0dh,0ah,0
     spacer BYTE " ",0dh,0ah,0 ;Spacer
     buffer BYTE 256 DUP(?) ;Buffer for string storage
     buffer2 BYTE 256 DUP(?) ;Buffer for more string storage
     finalString BYTE 512 DUP(?) ;Buffer for final string in exercise 3
	
.code
main proc
     ;Exercise 1
     call WriteStringLength
     ;Exercise 2
     call CountOccurrences
     ;Exercise 3
     call ConcatStrings
	invoke ExitProcess,0
main endp

;Exercise 1
;WriteStringLength
;Prompts user for string, then prints out the strings lenght in decimal and hexadecimal
;and then prints the string again
WriteStringLength proc
     mov	edx,OFFSET prompt1 ;put offset of string into EDX
	call WriteString ;write string to console
     mov edx, OFFSET buffer ;point to buffer
     mov ecx, SIZEOF buffer ;max characters (256 bytes)
     call ReadString ;get string from keyboard, store in buffer. Character count in EAX.
     call WriteDec ;display character count in decimal
     mov edx, OFFSET spacer ;provide space/new line
     call WriteString ;write space/new line
     call WriteHex ;display character count in hex
     Call WriteString ;write space/new line
     mov edx, OFFSET buffer ;put edx back at entered string
     call WriteString ;write string
     mov edx, OFFSET spacer ;provide space/new line
     call WriteString ;write space/new line
     ret ;return to calling function
WriteStringLength endp

;Exercise 2
;CountOccurences
;Prompts user for string and char. Then counts number of occurences of char in string.
CountOccurrences proc
     mov edx, OFFSET prompt1 ;put offset of prompt into EDX
     call WriteString ;prompt for sentence
     mov edx, OFFSET buffer ;point to buffer
     mov ecx, SIZEOF buffer ;max Characters (256 bytes)
     call ReadString ;get string from keyboard, store in buffer.
     mov edx, OFFSET prompt2 ;put offset of prompt into edx
     mov ecx, eax ;put number of characters from eax into ecx for loop counter
     call WriteString ;prompt for character
     call ReadChar ;read char, put into AL
     ;Have string and char, now count occurrences.
     mov esi, OFFSET buffer ;put esi at beginning of sentence
     mov dl, 0 ;counter for occurences
L1:  cmp al, [esi] ;compare [esi] and character entered by user
     jnz L2 ;jump if al != [esi]
     inc dl ;if didn't jump they are the same, +1 occurence
L2:  inc esi ;update esi to next character
     loop L1
     ;Number of occurences now stored in DL.
     mov eax, 0h ;clear EAX
     mov al, dl ;move number of occurences into al
     call WriteDec ;write number of occurences in decimal
     mov edx, OFFSET spacer ;provide space/new line
     call WriteString ;write space/new line
     ret ;return to calling function
CountOccurrences endp

;Exercise 3
;ConcatStrings
;Prompts user to enter two strings, then Concatenates the two strings 
;and displays it, as well as the length in both decimal and hexadecimal
ConcatStrings proc
     mov edx, OFFSET prompt3 ;set edx to prompt3
     call WriteString ;prompt for first sentence
     mov edx, OFFSET buffer ;point to buffer
     mov ecx, SIZEOF buffer ;max characters (256 bytes)
     call ReadString ;get string from keyboard, store in buffer
     mov ebx, eax ;store size of first string in ebx for safe keeping
     mov edx, OFFSET prompt4 ;set edx to prompt4
     call WriteString ;prompt for second sentence
     mov edx, OFFSET buffer2 ;point to buffer
     mov ecx, SIZEOF buffer2 ;max characters (256 bytes)
     call ReadString ;get string from keyboard, store in buffer
     ;Now have both strings. Now must concatenate them.
     ;esi = source
     ;edi = destination
     cld ;cear D to go forward with MOVSB
     mov esi, OFFSET buffer ;first source is first string.
     mov edi, OFFSET finalString ;final string after concatenation
     mov ecx, ebx ;use size of first string in loop/rep counter
     rep movsb ;copy value from esi to edi
     ;First string is now in finalstring. Time to add second string.
     mov esi, OFFSET buffer2 ;second string
     mov ecx, eax ;eax = size of 2nd string
     rep movsb ;copy value from esi to edi
     ;Strings now concatenated, now print size and final string
     mov edx, OFFSET finalString ;move edx to prepare to write final string
     call WriteString ;write final string
     mov edx, OFFSET spacer ;create spacer
     call WriteString ;space
     call WriteDec ;display character count in decimal
     call WriteString ;write space/new line
     call WriteHex ;display character count in hex
     Call WriteString ;write space/new line
     ret ;return to calling function
ConcatStrings endp

end main