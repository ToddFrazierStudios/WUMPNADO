.include "macros.asm"

.text

# checks to see if two strings are equal
#PARAMETERS:
# $a0 - the address of the first null-terminated string
# $a1 - the address of the second null-terminated string
#DESTROYS:
# $t0 - $t3
#RETURN:
# $v0 - will be zero if the strings are equal
.globl comparestr
comparestr: pushra
	li $v0, 0
	add $t0, $a0, $0
	add $t1, $a1, $0
	
	comparestr_loop:
		lb $t2, ($t0)
		lb $t3, ($t1)
		
		beqz $t2, comparestr_oneiszero
		beqz $t3, comparestr_oneiszero
		
		sub $v0, $t2, $t3
		bnez $v0, comparestr_return
		addi $t0, $t0, 1
		addi $t1, $t1, 1
		j comparestr_loop
		
	comparestr_oneiszero:
		sub $v0, $t2, $t3
		
comparestr_return: return