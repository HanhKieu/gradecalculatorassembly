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
	
	hwprompt BYTE "Enter the four hw grades : ", 0
	hwtext BYTE "Hw0: ",0
	
	Labs BYTE 4 DUP(?) ;allocates 4 unintialized BYTES to store our lab scores
	Homeworks BYTE 4 DUP(?);allocates 4 uninitialized BYTES to store homework scores
	
	midtermprompt BYTE "Enter the midterm exam grade: ",0
	finalprompt BYTE "Enter the final exam grade: ",0
	finalLabScore BYTE 1 DUP(?)
	finalHwScore BYTE 1 DUP(?)
	midtermScore BYTE 1 DUP(?)
	finalScore BYTE 1 DUP(?)

.code

main PROC

	;ESI STORES TEMPORARY SMALLEST INPUT FOR HOMEWORK AND ALSO SMALLEST INPUT FOR LABS
	;EDI STORES MEMORY LOCATION FOR ARRAY OF LABS AND HOMEWORK
	;EBX store temporary ACCUMULATOR
	;read LABS ---------------
	mov ebx, 0
	mov edx, OFFSET labprompt ;move first address to EDX so WriteString can display
	call WriteString

	mov ecx, 4
	mov edi, OFFSET Labs
	
	mov esi, 100 ;ESI CONTAINS CURRENT SMALLEST NUMBER
	loop1:
		inc [labtext + 3] ;labtext is "Lab0" it increments the 0 to 1 the first time, then 1 to 2, etc
		mov edx, OFFSET labtext
		call WriteString
		call ReadInt ;reads integer into EAX
		mov [edi], al ;moves the number you entered
		cmp [edi],esi ;if the number you entered isn't the smaller than the current smallest
		jg continueNormally ; then you don't want to store it as the smallest, so continue normally
		mov esi,[edi]					;if the number is smaller, then store it as the smallest
		continueNormally:
		add ebx, [edi]
		inc edi
		
		
	loop loop1
	
	sub ebx, esi ;DROPS THE LOWEST LAB SCORE
	mov edi, OFFSET finalLabScore 
	mov [edi],ebx ;stores the finalLabScore in a variable

	;=========READS HOMEWORK ==========
	mov ecx, 4 ;make it loop 4 times
	mov edx, OFFSET hwprompt
	call WriteString
	mov edi, OFFSET Homeworks
	mov ebx, 0 ;reset accumulator

	
	mov esi, 100 ;ESI CONTAINS CURRENT SMALLEST NUMBER

	loop2:
		inc [hwtext + 2] ;hwtext is "Hw0" it increments the 0 to 1 the first time, then 1 to 2, etc
		mov edx, OFFSET hwtext
		call WriteString
		call ReadInt ;reads integer into EAX
		mov [edi], eax ;moves the number you entered
		
		cmp [edi],esi ;if the number you entered isn't the smaller than the current smallest
		jg continueNormally2 ; then you don't want to store it as the smallest, so continue normally
		mov esi,[edi];if the number is smaller, then store it as the smallest
		continueNormally2:
		add ebx, [edi]
		inc edi
		
	loop loop2
	
	sub ebx, esi
	mov edi, OFFSET finalHwScore
	mov [edi],ebx ;STORES finalHwScore in variable
	
	
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

	loop3:

	add ebx,[edi]
	
	loop loop3
	
	mov [edi],bl

	
	;=====MULTIPLY HT BY 3 ======
	mov edi , OFFSET finalHwScore
	mov ebx,0
	mov ecx,3
	loop4:
	
	add ebx,[edi]
	

	loop loop4
		
	
	mov [edi],bl
	
	
	;=====MULTIPLY EM BY 15 ======
	mov edi , OFFSET midtermScore
	mov ebx,0
	mov ecx,15
	loop5:
	
	add ebx,[edi]
	

	loop loop5
		
	
	mov [edi],bl
	
	;=====MULTIPLY EF BY 21 ======
	mov edi , OFFSET finalScore
	mov ebx,0
	mov ecx,21
	loop6:
	add ebx,[edi]
	loop loop6
	mov [edi],bl
	
	;=====ADD UP LAB SCORE, HW SCORE, MIDTERM, AND FINAL

	mov ebx, 0
	mov edi, [OFFSET finalLabScore]
	add ebx, [edi]
	mov edi, [OFFSET finalHwScore]
	add ebx, [edi]
	mov edi, [OFFSET midtermScore]
	add ebx, [edi]
	mov edi, [OFFSET finalScore]
	add ebx, [edi]
	;EBX NOW CONTAINS THE SUMMED UP NUMERATOR
	
	
	mov ecx, 1000
	mov edi, 0
	
	loop7:
	
	sub ebx, 60
	cmp bl,1
	jl finalPortion
	inc edi			;edi is a counter, and will be our answer

	loop loop7
	

	finalPortion:
	mov edx, edi
	movzx eax,al
	call WriteInt
	
	
	
	
	
	

	

exit
main ENDP



END main

