.eqv CONSOLE 0x10020000

.macro push (%r)
	sw %r, ($sp)
	subi $sp, $sp, 4
.end_macro

.macro pushsp
	push $sp
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
