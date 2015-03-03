;HANH KIEU
;998358482
;hckieu@ucdavis.edu
TITLE Lab Assignment 3 (lab3.asm)



INCLUDE Irvine32.inc

;==========================
; Enter the four lab grades
; Lab1: 67
; Lab2: 73
; Lab3: 86
; Lab4: 24
; Enter the four Hw grades
; Hw1: 90
; Hw2: 67
; Hw3: 45
; Hw4: 88
; Enter the midterm exam grade: 75
; Enter the final exam grade: 95
; Total Grade = +82

;===========================

.data

	labprompt BYTE "Enter the four lab grades", 0 ;Each string with null terminator
	labtext BYTE "Lab0: ", 0
	
	hwprompt BYTE "Enter the four Hw grades", 0
	hwtext BYTE "Hw0: ",0
	
	Labs BYTE 4 DUP(?) ;allocates 4 unintialized BYTES to store our lab scores
	Homeworks BYTE 4 DUP(?);allocates 4 uninitialized BYTES to store homework scores
	
	midtermprompt BYTE "Enter the midterm exam grade: ",0
	finalprompt BYTE "Enter the final exam grade: ",0
	totalGrade BYTE "Total Grade = ",0
	letterGrade BYTE "Letter Grade = ",0
	finalLabScore BYTE 1 DUP(?)
	finalHwScore BYTE 1 DUP(?)
	midtermScore BYTE 1 DUP(?)
	finalScore BYTE 1 DUP(?)
	
	labScoreAfterMult WORD 1 DUP(?)
	hwScoreAfterMult WORD 1 DUP(?)
	midtermScoreAfterMult WORD 1 DUP(?)
	finalScoreAfterMult WORD 1 DUP(?)
	

.code

main PROC

	;ESI STORES TEMPORARY SMALLEST INPUT FOR HOMEWORK AND ALSO SMALLEST INPUT FOR LABS
	;EDI STORES MEMORY LOCATION FOR ARRAY OF LABS AND HOMEWORK
	;EBX store temporary ACCUMULATOR
	;read LABS ---------------
	mov ebx, 0
	mov edx, OFFSET labprompt ;move first address to EDX so WriteString can display
	call WriteString
	call CrlF ;ADDS A NEW LINE

	mov ecx, 4
	mov edi, OFFSET Labs
	
	mov esi, 100 ;ESI CONTAINS CURRENT SMALLEST NUMBER
	loop1:
		inc [labtext + 3] ;labtext is "Lab0" it increments the 0 to 1 the first time, then 1 to 2, etc
		mov edx, OFFSET labtext
		call WriteString
		call ReadInt ;reads integer into EAX
		mov [edi], al ;moves the number you entered
	
		mov edx, 0
		mov edx,esi
		cmp [edi],dl ;if the number you entered isn't the smaller than the current smallest
		
		jg continueNormally ; then you don't want to store it as the smallest, so continue normally
		mov esi,[edi]					;if the number is smaller, then store it as the smallest
		continueNormally:
		add ebx, [edi]
		inc edi
		
		
	loop loop1
	
	sub ebx, esi ;DROPS THE LOWEST LAB SCORE
	mov edi, OFFSET finalLabScore 
	mov [edi],bl ;stores the finalLabScore in a variable
	mov edx, esi ;JUST TO CHECK VALUES

	

	

	
	
	

	;=========READS HOMEWORK ==========
	mov ecx, 4 ;make it loop 4 times
	mov edx, OFFSET hwprompt
	call WriteString
	call CrlF
	mov edi, OFFSET Homeworks
	mov ebx, 0 ;reset accumulator

	
	mov esi, 100 ;ESI CONTAINS CURRENT SMALLEST NUMBER


	loop2:
		inc [hwtext + 2] ;hwtext is "Hw0" it increments the 0 to 1 the first time, then 1 to 2, etc
		mov edx, OFFSET hwtext
		call WriteString
		call ReadInt ;reads integer into EAX
		mov [edi], al ;moves the number you entered
	
		
		
		mov edx, 0
		mov edx,esi
		cmp [edi],dl ;if the number you entered isn't the smaller than the current smallest
		jg continueNormally2 ; then you don't want to store it as the smallest, so continue normally
		mov esi,[edi];if the number is smaller, then store it as the smallest
		continueNormally2:
		add ebx, [edi]
		inc edi
		
	loop loop2
	
	sub ebx, esi
	mov edi, OFFSET finalHwScore
	mov [edi],bl ;STORES finalHwScore in variable
	mov edx, esi ;JUST TO CHECK VALUES
	

	
	;===============MIDTERM PROMPT==========

	mov edx, OFFSET midtermprompt
	call WriteString
	call ReadInt

	mov edi, OFFSET midtermScore
	mov [edi],al
	
	
	;============FINAL PROMPT============
	mov edx, OFFSET finalprompt
	call WriteString
	call ReadInt
	mov edi, OFFSET finalScore
	mov [edi],al
	
	
	;=====MULTIPLY LT BY 5===== 
	mov edi, OFFSET finalLabScore

	mov ebx,0
	mov ecx, 5
	mov edx, 0

	loop3:
	mov dl,[edi]
	add ebx, edx
	loop loop3
	
	
	mov edi, OFFSET labScoreAfterMult
	mov [edi],bx


	
	;=====MULTIPLY HT BY 3 ======
	
	mov edi , OFFSET finalHwScore

	
	mov ebx,0
	mov edx, 0
	mov ecx,3
	loop4:
	mov dl,[edi]
	add ebx,edx
	

	loop loop4
		
	mov edi, OFFSET hwScoreAfterMult
	mov [edi],bx
	
	
	;=====MULTIPLY EM BY 15 ======
	mov edi , OFFSET midtermScore
	mov ebx,0
	mov ecx,15
	mov edx, 0
	loop5:
	mov dl, [edi]
	add ebx,edx
	

	loop loop5
		
	mov edi, OFFSET midtermScoreAfterMult
	mov [edi],bx

	
	;=====MULTIPLY EF BY 21 ======
	mov edi , OFFSET finalScore
	mov ebx,0
	mov ecx,21
	mov edx, 0
	loop6:
	mov dl, [edi]
	add ebx,edx
	loop loop6
	mov edi, OFFSET finalScoreAfterMult
	mov [edi],bx

	
	;=====ADD UP LAB SCORE, HW SCORE, MIDTERM, AND FINAL

	mov ebx, 0
	mov edx, 0
	mov edi, OFFSET labScoreAfterMult
	
	mov dx, [edi]
	add ebx, edx
	mov edi, OFFSET hwScoreAfterMult
	mov dx, [edi]
	add ebx, edx
	mov edi, OFFSET midtermScoreAfterMult
	mov dx, [edi]
	add ebx, edx
	mov edi, OFFSET finalScoreAfterMult
	;mov edx, [edi];checke
	; call DumpRegs
	mov dx, [edi]
	add ebx, edx
	;EBX NOW CONTAINS THE SUMMED UP NUMERATOR ;contains 4985

	
	mov ecx, 1000;just made it a huge number bc I'm a lazy programmer ;)
	mov edi, 0
	mov edx, ebx
	
	
	loop9:
	
	sub bx, 16
	cmp bx,1 ;if bx reaches less than 1
	jl divideBySixty
	inc edi	
	
	
	loop loop9; 4985/16
	
	
	
	
	
	
	
	
	divideBySixty:
	
	mov ebx, 0
	mov ebx, edi ;edi contains 4985 /16 for example
	add ebx, edx  ;4985 + 4985 /16
	mov ecx, 100
	mov edi, 0

	loop7:
	
	sub bx, 64
	cmp bx,1
	jl finalPortion
	inc edi			;edi is a counter, and will be our answer

	loop loop7 ;and final divide that by 64
	
	
	finalPortion:
	mov eax, 0
	mov edx, 0
	mov edx, edi
	mov eax,edx
	mov edx, OFFSET totalGrade
	call Crlf ;newline
	call WriteString
	call WriteInt
	call Crlf 
	mov edx, OFFSET letterGrade
	call WriteString
	
	cmp	al, 85
	jg Alabel
	cmp al, 75
	jg Blabel
	cmp al, 65
	jg Clabel
	cmp al, 59
	jg Dlabel
	
	mov al, 'F'
	
	
	Alabel:	
		mov al, 'A'
		jmp finished

	Blabel:	
		mov al, 'B'
		jmp finished

	Clabel: 
		mov al, 'C'
		jmp finished

	Dlabel:	
		mov al, 'D'
		jmp finished
		
	finished:
		call WriteChar
		call Crlf
	
	

	
	
	
	
	

	

	exit
main ENDP



END main


