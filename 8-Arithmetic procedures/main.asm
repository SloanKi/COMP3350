; Module 8 
; 7/12/2018 Sloan Kiechel
INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	promptHex64 BYTE "Please enter a 64 bit in Hexadecimal (8 Bytes)", 0Dh, 0Ah, 0
     promptUpper32 BYTE "Please Enter the upper 32 bits (4 bytes) of the Hexadecimal number", 0Dh, 0Ah, 0
     promptLower32 BYTE "Please Enter the lower 32 bits (4 bytes) of the Hexadecimal number", 0Dh, 0Ah, 0
     promptHex32 BYTE "Please enter a 32 bit in Hexadecimal (4 Bytes)", 0Dh, 0Ah, 0
     hexIndicator BYTE "h", 0Dh, 0Ah, 0
     buffer BYTE 11 DUP(?)
	
.code
main proc
     ;exercise 1
     ;call HexSum

     ;Exercise 3
     call HexToOctal

	invoke ExitProcess,0
main endp

;Exercise 1: HexSum
;Prompts user to enter two 64 bit hex numbers. Adds these numbers, and prints the resulting sum.
;No requirements
;Uses edx, ecx, eax, and ebx as intermediary registers
;No result register
HexSum proc
     ;save registers
     push edx
     push ecx
     push eax
     push ebx
     
     ;Get hex numbers
     call getHexNumbers

     ;Add the numbers
     ;Recall, N1 is Stored in ebx (upper bits) and ecx (lower bits)
     ;N2 is stored in edx (upper bits) and eax (lower bits)
     add ecx, eax ;add lower bits
     jnc Upper ;if carry is not set, jump to upper
     add ebx, 1 ;if carry is set, add 1 to upper bits.
     jnc Upper ;if carry is not set, jump to upper
     mov al, 31h 
     call WriteChar ;if carry is set after incrementing upper, put a 1 before the rest of the number
     Upper: ;add upper bits
          add ebx, edx
          jnc print ;if carry not set, print the numbers as is

     ;print new number
     ;Upper 32 bits stored in ebx, lower 32 bits stored in ecx
     mov al, 31h 
     call WriteChar ;if carry is set after adding uppers write a 1 before the rest of the number
     print: ;if carry is not set, skip here (print just the numbers)
          mov eax, ebx ;move upper 32 into eax to print
          call WriteHex
          mov eax, ecx ;move lower 32 into eax to print
          call WriteHex
          mov edx, OFFSET hexIndicator ;Print "h" to indicate hex number
          call WriteString

     ;restore registers
     pop ebx
     pop eax
     pop ecx
     pop edx

     ;return to calling procedure
     ret
HexSum endp

;Exercise 2: HexProduct
;Prompts user to enter two 64 bit hex numbers. Multiplies these numbers, prints the resulting product
;No requirements
;Uses edx, ecx, eax, and ebx as intermediary registers
;No result register
;Note: this does not work.
HexProduct proc
     ;save registers
     push edx
     push ecx
     push eax
     push ebx

     ;Get hex numbers
     call getHexNumbers

     ;multiply the numbers
     ;Recall, N1 is Stored in ebx (upper bits) and ecx (lower bits)
     ;N2 is stored in edx (upper bits) and eax (lower bits)
     ;Since edx:eax is where our products will be stored, move N2 to edi and esi
     mov edi, edx ;upper bits
     mov esi, eax ;lower bits
     
     mul ecx ;multiply lower bits, store in edx:eax
     call WriteHex ;lower 32 of product stored in eax

     pop edx ;save edx for later
     mov eax, edi
     mul ebx 
     pop eax ;save for later
     pop edx ;save for later
     mov eax, esi
     mul ecx




     ;restore registers
     pop ebx
     pop eax
     pop ecx
     pop edx

     ;Return to calling procedure
     ret
HexProduct endp

;Exercise 3: HexToOctal
;Prompts for a 32 bit hexadecimal integer, then converts the number to base 8 and displays it
;No requirements, no result register
HexToOctal proc
     ;save registers
     push edx
     push eax
     push ebx
     push ecx
     push edi

     ;prompt for 32 bit hex
     mov edx, OFFSET promptHex32
     call WriteString

     ;get hex
     call ReadHex ;saves hex number into eax

     ;Convert to octal and print
     mov ecx, 11 ;loop counter
     mov edi, OFFSET buffer
     add edi, 10 ;set edi to the end of the buffer
     myLoop:
          mov bl, al ;move byte to bl to manipulate
          and bl, 07h ;max octal = 07h
          add bl, '0' ;convert to ASCII
          mov [edi], bl ;save into buffer
          dec edi ;move buffer one
          SHR eax, 3 ;shift to next octal bit
          loop myLoop 
     ;write result
     mov edx, OFFSET buffer
     call WriteString

     ;restore registers
     pop edi
     pop ecx
     pop ebx
     pop eax
     pop edx

     ;return to calling function
     ret
HexToOctal endp


;**********************************************************************************************************;
;****************************************Extra Procedures**************************************************;
;**********************************************************************************************************;


;getHexNumbers is a procedure to shorten my code.
;Prompts for and retrieves two 64 bit hex numbers from user.
;No requirements, no intermediary register
;Result registers:
;N1 is Stored in ebx (upper bits) and ecx (lower bits)
;N2 is stored in edx (upper bits) and eax (lower bits)
getHexNumbers proc
     ;Prompt for first number
     mov edx, OFFSET promptHex64 
     call WriteString
     mov edx, OFFSET promptUpper32
     call WriteString ;Prompt for upper 32
     mov edx, Offset promptLower32

     ;Receive 64bit hex number, N1
     call ReadHex ;stores 32bit hexadecimal integer into EAX (Upper 32 bits)
     mov ebx, eax ;store upper 32 bits of N1 into ebx
     call WriteString ;prompt for lower32
     call ReadHex ;stores 32bit hexadecimal integer into EAX (lower 32 bits)
     mov ecx, eax ;store lower 32 bits of N1 into ebx

     ;prompt for second number
     mov edx, OFFSET promptHex64 
     call WriteString
     mov edx, OFFSET promptUpper32
     call WriteString ;Prompt for upper 32
     mov edx, Offset promptLower32

     ;Receive 64bit hex number, N2
     call ReadHex ;stores 32bit hexadecimal integer into EAX (upper 32 bits)
     call WriteString ;prompt for lower 32
     mov edx, eax ;store upper 32 bits of N2 into edx
     call ReadHex ;stores 32bit hexadecimal integer into EAX (lower 32 bits)

     ;return to calling function
     ret
getHexNumbers endp

end main