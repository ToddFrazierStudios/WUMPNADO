.eqv CONSOLE 0x10020000

.macro pushSP
	sw $ra, ($sp)
	subi $sp, $sp, 4
.end_macro

.macro return
	addi $sp, $sp, 4
	lw $ra, ($sp)
	j $ra
.end_macro