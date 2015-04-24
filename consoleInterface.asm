.include "macros.asm"

.text

.eqv CONSOLE_CHARS_PER_ROW 80

#prints a string to the console starting at the given cordinates
#PARAMETERS:
# $a0 - the row number
# $a1 - the column number of the first character
# $a2 - the address of a null-terminated string to print
#DESTROYED:
# $a0
# $a1
# $a2


.globl console_printstring
console_printstring: pushsp
	
	#first we need to find the character index we are printing to and store it in $a0
	mul $a0, $a0, CONSOLE_CHARS_PER_ROW
	add $a0, $a0, $a1
	
	# $a0 is the memory address in the buffer that we are writing to

	console_printstring_loop:
		lb $a1, ($a2) #load the character from the string
		beqz $a1, console_printstring_return #if we hit the null character, return
	
		sb $a1, CONSOLE($a0) #print the character
		
		addi $a0, $a0, 1 #increment the buffer address
		addi $a2, $a2, 1 #increment the string address
		j console_printstring_loop
	
console_printstring_return: return
