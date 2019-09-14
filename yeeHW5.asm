;benjamin yee
Title Homework5.asm
include irvine32.inc

newline textequ <0Ah, 0dh>
;//macros to clear registers
move textequ <mov>
clearEax textequ <move eax,0>
clearEbx textequ <move ebx,0>
clearEcx textequ <move ecx,0>
clearEdx textequ <move edx,0>
clearEsi textequ <move esi,0>
clearEdi textequ <move edi,0>

.data
ourString Byte 51 dup(0)
choice Byte ?
stringLenght byte 0d

.code
Main proc
mov eax,0
;// clear registers here
call ClearReg
startHere:
call clrscr
;//Display the menu
call displayMenu
mov choice, al

;//Branching Conditions
cmp choice, 6
;// if 6 exit
;// if <6 check for >0
;// >6 invalid input, redisplay menu
jz byebye ;//6 was entered

cmp choice, 7
jae Error
cmp choice,0
jbe Error

cmp choice, 1
jne opt2
mov edx, offset ourString
mov ecx, sizeof ourString
call option1
jmp startHere

cmp choice, 2
jne opt3
call option2
jmp startHere

cmp choice, 3
jne opt4
call option3
jmp startHere

cmp choice, 4
jne opt5
call option4
jmp startHere

opt5:
call option5
jmp startHere
opt2:
call option2
jmp startHere
opt3:
call option3
jmp startHere
opt4:
call option4
jmp startHere








Error:
call Oops
jmp startHere


byebye:
exit
Main endp

;//Procedures
displayMenu proc 
;//Function header here
.data
Menu Byte "Menu", newline,
	"1. Enter a string", newline,
	"2. Convert the string to lower case", newline,
	"3. Remove all non-letter elements", newline,
	"4. Is it a palindrome?", newline,
	"5. Print the string", newline,
	"6. Quit", newline,
	"Please enter your choice: ",newline,0


.code
mov edx, offset Menu
call writeString
call readDec ;//returns in eax

ret
displayMenu endp

Oops proc
;//Header
.data
oopsMessage Byte "Invalid choice, please try again", newline, 0

.code
mov edx, offset oopsMessage
call writeString
call waitMsg

ret
Oops endp

option1 proc
;//Header
.data
userPrompt1 Byte "Enter your String: ",0
.code
;//Write procedure to clear the string
push edx
mov edx, offset userPrompt1
call writeString
pop edx
call readString
ret 
option1 endp

option2 proc
;convert all elements of the string to lower case 
;//Header
.data
enterString1 byte "please back to option 1 so that there is a string and then come back 2", newline,0
.code
cmp stringLenght,0;checks if there is any string there
je GobackOp1
mov ebx,0
push edx
call writeString;prints to screen
pop edx
call option5 ;shows the strings
call crlf;clears line
push edx
L2:
mov al, byte ptr[edx+ebx]
cmp al, 'A';check with A
jb isLcase;will always jump unless it is zero
cmp al,'Z';check against Z
jl isLcase;jumps if it is less then Z
sub al ,20h
mov byte ptr [edx+ebx], al
isLcase: 
inc ebx
loop L2
pop edx
call option5

ret

GobackOp1:
mov edx, offset enterString1;move the please input string message to edx
call writeString;prints to screen
ret
option2 endp

option3 proc
;remove all the non-letter charaters 
;//Header
.data
option3m1 byte "og :" ,newline,0;original
option3m2 byte "result :",newline,0
option3m3 byte "please back to option 1 so that there is a string and then come back 3", newline,0
tmpArray byte 101d dup (0);holds the thing that is to hold the actual letters
.code
push edx
cmp stringLenght,0 ;check if there is string
jne stillGoing
mov edx, offset option3m3;message 3
call writeString
call waitmsg
pop edx

stillGoing:
mov edx, offset option3m1 ;message 1
call writeString
mov edx, offset ourString;puts string edx
call option5;shows screen
push edx
mov edx, offset ourString
mov cl, stringLenght
mov edi, offset tmpArray
jmp L3

L3:
mov al, [edx+esi]
cmp al, 30h
jb isntLetter
cmp al,3Ah
jl isLetter
cmp al, 40h
jb isntLetter
cmp al, 5Bh
jl isLetter
cmp al,61h
jb isntLetter
cmp al,7Bh
jl isLetter
inc esi 

isLetter:
mov [edi],al 
inc esi
inc edi
loop L3
isntLetter:
inc esi
loop L3
cmp ecx,0
je finished

finished: 
mov [edi],al
call ClearString 
mov cl, stringLenght
mov edi, offset tmpArray

L3p1:
mov al, [edi]
mov [edx], al
inc edi
inc edx 
loop L3p1

mov edx, offset tmpArray
call ClearString
mov edx, offset option3m2
call writeString
mov edx, offset ourString
call option5
call crlf
pop edx 
pop edi 
call waitmsg
ret
option3 endp

option4 proc
;will determine if the string is a palindrome 
;//Header
.data
option4m1 byte "og :",newline,0
option4m2 byte "the string is a palindrome",newline,0
option4m3 byte "the string isn't a palindrome",newline,0
option4m4 byte "modified string :", 0
tmpArray1 byte 101d dup (0)
temp word 0
temp1 byte 0
.code
mov edx, offset ourString
mov edi, offset tmpArray1
L4:
mov bl,[edx]
mov [edi], bl
inc edi
inc edx 
loop L4

L4p1:;same as L2 
mov al, byte ptr[edx+esi]
cmp al, 'A'
jb isLcase
cmp al,'Z'
ja isLcase
sub al ,20h

mov byte ptr [edx+esi], al
isLcase: 
inc esi
loop L4p1
mov edx, offset option4m4
call writeString
pop edx
clearEsi
clearEdi
mov edx, offset ourString
push edx 
mov edx, offset option4m1
call writeString
pop edx
call option5
call crlf 
mov cl, stringLenght
push edx 
mov cl, stringLenght
mov edi, offset tmpArray1
mov esi, offset tmpArray1
add edi,ecx 
dec edi 
L4p2:;loop L4p2
mov ah,[esi]
mov al,[edi]
cmp ah,al
jne isntPalindrome 
dec edi
inc esi 
loop L4p2 ;end of L4_2
mov edx, offset option4m2
call writeString
pop edx
ret
isntPalindrome:
mov edx, offset option4m3
call writeString
mov ecx,0
pop edx
ret 

option4 endp

option5 proc
;display to the screen 
;//Header
.data
.code
call writeString
call waitMsg
ret
option5 endp

ClearReg proc 
;clears the registers 
clearEax
clearEbx
clearEcx
clearEdx
clearEsi
clearEdi

ret
ClearReg ENDP

ClearString proc
mov ecx, Lengthof ourString
l3:
mov[edx+ecx-1],byte ptr 0
loop L3
ret 

ClearString endp

end Main