.eqv CONSOLE 0x10020000
.eqv CONSOLE_CHARS_PER_ROW 80
.eqv CONSOLE_NUMBER_OF_ROWS 25
# 25 * 80 = 2000
.eqv CONSOLE_BUFFER_SIZE 2000

.macro push (%r)
	sw %r, ($sp)
	subi $sp, $sp, 4
.end_macro

.macro pushra
	push $ra
.end_macro

.macro pop (%r)
	addi $sp, $sp, 4
	lw %r, ($sp)
.end_macro

.macro return
	pop $ra
	jr $ra
.end_macro

.macro END_PROGRAM
	li $v0, 10
	syscall
.end_macro

.macro delay (%t)
	li $v0, 30
	syscall
	addi $t0, $a0, %t
	delayloop: 
		syscall
		blt $a0, $t0, delayloop
.end_macro
