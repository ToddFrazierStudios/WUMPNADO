.include "macros.asm"

.data
string: .asciiz "This is a test string! wooo! \n let's see what a newline does!"
.text

.globl main
main:
	li $a0, 3
	li $a1, 3
	la $a2, string
	jal console_printstring
	
	#END_PROGRAM
	li $v0, 10
	syscall
