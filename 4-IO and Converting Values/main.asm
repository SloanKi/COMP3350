; Module 4 programming assignment
; 6/14/18 Sloan Kiechel
INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
     myString BYTE "h",0dh,0ah ;Add h and move to new line
     myString2 BYTE " ", 0dh, 0ah ;newline
	
.code
main proc
     ; Assignment 1
     mov al, 06h ;Test variable
     mov dl, 30h
     add dl, al ;ASCII digits 0-9 are 30h-39h
     mov al, dl ;Put ascii in al so writechar can write.
     call WriteChar ;displays al
     mov edx, offSet myString2
     call writeString ;creates new line

     ;Assignment 2
     mov al, 57h ;Test variable
     mov dh, al 
     AND dh, 0F0h ;Get most significant nibble, zero out other nibble.
     shr dh, 4 ;shift 4 to move MSN to LSN. 
     add dh, 30h ;Add 30h to get ASCII code.
     mov dl, al
     and dl, 0Fh ;Get least significant nibble, zero out other.
     add dl, 30h ;add 30h to get ASCII code.
     mov al, dh ;Put dh in al so writechar can display.
     call WriteChar ; displays al
     mov al, dl ;move dl to al so it can print
     mov edx, OFFSET myString 
     call WriteChar ; display al;
     call writeString ;writes h and moves to new line

     ;Assignment 3
     call ReadChar ;read char from keyboard, store in al
     mov dl, al
     sub dl, 30h ;AL contains ascii for digit, which is 30-39. Subtracting 30 gives the value.

     ;Assignment 4
     call ReadChar ;read first digit into al (most significant nibble)
     mov dl, al ;temporarily put first digit into dl
     call ReadChar ;read second digit into al (least significant nibble)
     sub dl, 30h ;change from ascii to value
     sub al, 30h ;change from ascii to value
     shl dl, 4 ;Since dl has most signifcant, shift it left to make it first.
     add al, dl ;Adding dl to al puts the value of input into al




	invoke ExitProcess,0
main endp
end main