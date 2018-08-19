; Module 3 
; 6/6/2018 Sloan Kiechel
INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	myString BYTE "Hello World",0dh,0ah
	
.code
main proc
     mov eax, 0FFFDh
     inc eax
     inc eax
     inc eax
     mov eax, 0FFFDh
     inc al
     inc al
     inc al

	invoke ExitProcess,0
main endp
end main