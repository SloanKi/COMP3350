; Module 9
; 07/19/2018 Sloan Kiechel
INCLUDE Irvine32.inc
.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
     ;Exercise 1 prompts
	promptHex BYTE "How many numbers would you like to enter? (enter a 32-bit hexadecimal number): ",0dh,0ah,0
     promptHex2 BYTE "Enter a 32-bit hexadecimal number: ", 0dh, 0ah, 0
     ;Spacer to start a new line
     spacer BYTE " ",0dh,0ah,0 ;Spacer
     ;Array Buffer for Exercise 1
	ArrayBuffer DWORD 256 DUP(?) 
     ;Exercise 2 prompts
     promptS1 BYTE "Please enter a sentence S1 to search: ", 0dh, 0ah, 0
     promptS2 BYTE "Please enter a sentence S2 in which to search S1: ", 0dh, 0ah, 0
     S1Buffer BYTE 256 DUP(?)
     S2Buffer BYTE 256 Dup(?)
     byteCountS1 DWORD ?
     byteCountS2 DWORD ?
.code
main proc
     ;exercise 1
     call sortHex
     ;Exercise 2
     call SearchString
	invoke ExitProcess,0
main endp


; Exercise 1:
; Prompts user to enter a hexadecimal number n, prompts the user to enter n 32-bit numbers,
; stores the numbers in an array, sorts them in increasing order, and displays the array.
sortHex proc
     ;save registers
     push edx
     push ecx
     push edi
     push eax
     push esi
     push ebx

     ;prompt for how many hexadecimal numbers they will enter
     mov edx, offset promptHex
     call WriteString
     call ReadHex ;stores hex number into EAX
     mov ecx, eax ;store n into ecx, our loop counter
     push ecx ;save counter, will have to use again later.

     ;get numbers and store in an array
     mov edx, offset promptHex2
     mov edi, offset ArrayBuffer
     getNumber: 
          call WriteString ;Prompt for number
          call ReadHex ;store number into eax
          mov [edi], eax ;store in array
          add edi, 4 ;increment edi 4 bytes, 32 bits
          loop getNumber

     ;if only 1, don't sort, jump to display
     pop ecx ;retrieve N (number of numbers)
     cmp ecx, 1
     jz display

     ;sort array
     push ecx ;store one more time, will need again.
     dec ecx ;Outer loop needs to go n-1 times.
     mov esi, OFFSET ArrayBuffer ;for outer loop
     outerLoop:
          mov edi, esi ;edi is for inner loop
          add edi, 4 ;start edi  at number after esi
          mov eax, [esi] ;put number from array into eax
          push ecx ;push loop counter so not lost
          innerLoop:
               mov edx, [edi] ;put next number into edx
               cmp edx, eax
               jbe done ;if below or equal, move to next iteration
               ;if not below or equal, move inner number to outer number's slot.
               mov [esi], edx ;move higher number into esi's spot.
               mov [edi], eax ;move lower number into edi's spot
               mov eax, edx
               done:
                    add edi, 4 ;increment edi to next number
                    loop innerLoop
          pop ecx ;restore outer loop counter
          add esi, 4 ;increment esi to next number
          loop outerLoop

     ;display array
     pop ecx ;restore loop counter one more time.
     display:
     mov edi, OFFSET ArrayBuffer
     mov edx, OFFSET spacer
     displayLoop:
          mov eax, [edi]
          call WriteHex
          call WriteString ;puts new line between numbers
          add edi, 4 ;move edi to next number
          loop displayLoop

     ;restore registers
     pop ebx
     pop esi
     pop eax
     pop edi
     pop ecx
     pop edx

     ;return to calling function
     ret
sortHex endp

; Exercise 2:
; Prompts user for two strings. Searchs 2nd string for an occurence of the 1st string.
; Displays the position that S1 starts at in S2. 
; If S1 is not in S2, displays 0.
SearchString proc
     ;save registers
     push edx
     push ebx
     push ecx
     push eax
     push edi
     push esi

     ;prompt for S1
     mov edx, OFFSET promptS1
     call WriteString

     ;Retrieve and store S1
     mov edx, OFFSET S1Buffer
     mov ecx, SIZEOF S1Buffer
     call ReadString
     mov byteCountS1, eax ;Store # of characters


     ;Prompt for S2
     mov edx, OFFSET promptS2
     call WriteString

     ;Retrieve and store S2
     mov edx, OFFSET S2Buffer
     mov ecx, SIZEOF S2Buffer
     call ReadString
     mov byteCountS2, eax ;Store # of characters
     cmp eax, byteCountS1
     jb DoesNotExist ;if String1 is larger than string 2, then S1 is not in S2.

     ;Search for S1 in S2
     mov esi, OFFSET S1Buffer
     mov edi, OFFSET S2Buffer
     mov ecx, byteCountS2 ;loop size of S2
     mov ebx, 1 ;position
     cld
     SearchLoop:
          mov al, [esi]
          cmp al, [edi]
          jnz continue ;Not equal, skip forward
          ;If they are equal, see if rest of word is there.
          ;First see if there is enough room for S1 to be there
          cmp ecx, byteCountS1
          jb DoesNotExist ;If ecx < byteCountS1, not enough room for S1 to exist.
          ;If there is enough room, save edi and ecx
          push edi ;save edi position in case this isn't S1
          push ecx ;save ecx's count incase this isn't S1
          mov ecx, byteCountS1
          repe cmpsb ;Compare, continue as long as ECX >0 and equality.
          pop ecx ;put ecx back at whatever position it was at
          pop edi ;put edi back at whatever position it was at
          jz DoesExist ;if ended on equality, it does exist.

          continue:
          inc edi ;increment edi to next byte
          inc ebx ;increment bx to next position
          loop SearchLoop


     ;Display position or 0 if not
     DoesNotExist: ;If does not exist, display 0.
     mov al, 30h
     call WriteChar
     jmp Restore

     ;If exists, display the position.
     DoesExist:
     mov eax, ebx
     call WriteHex

     Restore:
     ;restore registers
     pop esi
     pop edi
     pop eax
     pop ecx
     pop ebx
     pop edx

     ;return to calling function
     ret
SearchString endp

end main