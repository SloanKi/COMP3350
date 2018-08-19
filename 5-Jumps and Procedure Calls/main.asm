; Module 5 programming assignment
; 6/14/18 Sloan Kiechel
INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	myString BYTE "h",0dh,0ah ;Add h and move to new line
	
.code
main proc
     ;Exercise 6
     call ReadHexByte ;Reads value N from user
     call SumFirstN ;sum 1 + 2 + ... + N

     ;Print out sum
     mov cx, dx
     mov al, ch ;move first two digits to al
     mov bl, 01h ;use this to tell writeHexByte to not put an h after first two digits
     call WriteHexByte ;print first two digits to console
     mov al, cl ;move second to digits to al
     mov bl, 00h ;Use this to tell writeHexByte to put an h after first two digits
     call WriteHexByte ;print last two digits to console

	invoke ExitProcess,0
main endp


;Exercise 1
;DigitValue2ASCII
;Digit 00h-0Fh is stored in AL, resulting ASCII returned in DL
DigitValue2ASCII proc
     mov dl, al
     cmp dl, 09h
     jbe l1 ;jump if dl is 9 or less
     ja l2 ;jump if dl is A-F
L1:  
     add dl, 30h ;ASCII of 0-9 is 30-39
     jmp L3 ;Jump to L3 so L2 doesn't execute
L2:
     sub dl, 0Ah 
     add dl, 41h ;ASCII of A-F is 41-46 
     
L3:
     ret ;Return to calling function
DigitValue2ASCII endp

;Exercise 2
;WriteHexByte
;Digit 00h-FFh stored in AL, written to console.
WriteHexByte proc
     mov dh, al ;Store AL's original value in dh to not lose it
     and al, 0F0h ;Get most significant nibble
     shr al, 4 ;Shift 4 to move to least significant nibble
     call DigitValue2ASCII ;will store in DL the ASCII of the most significant nibble
     mov al, dl ;move the ASCII from dl to al to print
     call WriteChar ;display ASCII in AL
     mov al, dh ;Move the original number back to al
     and al, 0Fh ;get least significant nibble
     call DigitValue2ASCII ;will store in DL the ASCII of the least significant nibble
     mov al, dl ;move ASCII from dl to al to print
     call WriteChar ;display ASCII in AL
     
     ;I edited this for exercise 6 to make printing out the sum easier. If bl = 01h, then it will not add an H and new line to the end.
     cmp bl, 01h
     JZ L2

L1:  ;Since can only use WriteChar and ReadChar (and not writestring), long way to print h and return
     mov al, 68h ;ASCII for "h"
     call WriteChar
     mov al, 0Ah ;Line feed
     call WriteChar
     mov al, 0Dh ;Carriage return
     call WriteChar

L2:     mov al, dh ;Return original value to al (incase needs to stay unchanged)
     ret ;return to calling function
WriteHexByte endp

;Exercise 3
;ASCII2DigitValue
;ASCII stored in AL, resulting value 00-0Fh stored in DL
ASCII2DigitValue proc
     mov dl, al ;move ASCII to dl
     cmp dl, 39h
     jbe l1 ;jump if dl is 39h or less (ASCII of 0-9)
     ja l2 ;jump if dl is more (ASCII of A-F)
L1:  
     sub dl, 30h ;ASCII of 0-9 is 30-39h
     jmp L3 ;Jump to L3 so L2 doesn't execute
L2:
     sub dl, 41h ;ASCII of A-F is 41-46h
     add dl, 0Ah
     
L3:
     ret ;Return to calling function
ASCII2DigitValue endp

;Exercise 4
;ReadHexByte
;Recieves 2 values from keyboard, stores value in AL.
ReadHexByte proc
     call ReadChar ;read first digit into al (most significant nibble)
     call ASCII2DigitValue ;Change first digit from ASCII to value, store in DL
     call ReadChar ;read second digit into al (least significant nibble)
     mov dh, dl ;temporarily put first digit into dh so it is not lost
     call ASCII2DigitValue ;change second digit from ASCII to value, store in DL
     mov al, dl ;move value of second digit to AL
     shl dh, 4 ;move dh 4 to make it most significant nibble
     add al, dh ;add AL and DH to create the actual value.
     ret ;return to calling function
ReadHexByte endp

;Exercise 5
;SumFirstN
;Store N in AL, add 1 + 2.... + n and store in DX
SumFirstN proc
     mov ecx, 0h ;Set ecx to zero first
     mov cl, al ;move N into CL, determines the number of loops 
     mov dx, 0h ;start dx at 0
     mov bx, 1h ;number to add each loop, start at 1
Sum:
     add dx, bx
     add bx, 1h  ;increment bx so next add is one more
     loop sum ;Loops unti ECX = 0
     ret ;Return to calling function
SumFirstN endp


;Test procedure used to test all other procedures
test1 proc
     ;Exercise 1 test values
     mov al, 05h 
     call DigitValue2ASCII ;DL should be 35h (53 dec)
     mov al, 0Ch
     call DigitValue2ASCII ;DL should be 43h (67 dec)

     ;Exercise 2 test values
     mov al, 15h
     call WriteHexByte ;Should print 15h
     mov al, 0E2h
     call WriteHexByte ;Should print E2h

     ;Exercise 3 Test values
     mov al, 33h
     call ASCII2DigitValue ; dl should contain 03h
     mov al, 45h
     call ASCII2Digitvalue ; dl should contain 0Eh

     ;Exercise 4 test
     call ReadHexByte
     call ReadHexbyte ;Call second time to allow another test of it

     ;Exercise 5 test
     mov al, 02h
     call SumFirstN ;DX should be 0003h
     mov al, 10h 
     call SumFirstN ;DX should be 136 (0088h)
     mov al, 0Fh
     call SumFirstN ;DX should be 120 (0078h) 

     ret 
test1 endp

end main