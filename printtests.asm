.include "macros.asm"

.data
string: .asciiz "This is a test string! wooo! \n let's see what a newline does!"
request: .asciiz "Enter a string: "
.text

.globl main2
main2:
	li $a0, 0
	li $a1, 0
	la $a2, string
	jal console_printstring
	
	
	li $a0, 11
	li $v0, 9
	syscall #allocate memory
	
	
	li $a0, 2
	li $a1, 0
	la $a2, request
	jal console_printstring
	
	li $a0, 3
	li $a1, 0
	add $a2, $v0, $0
	add $s0, $a2, $0
	li $a3, 10
	jal console_readline_and_print
	
	li $a0, 5
	li $a1, 3
	add $a2, $s0, $0
	jal console_printstring
	
	
	
	#END_PROGRAM
	li $v0, 10
	syscall
