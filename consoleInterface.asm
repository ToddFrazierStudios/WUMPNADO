.include "macros.asm"

.text

#prints a string to the console starting at the given cordinates
#PARAMETERS:
# $a0 - the row number
# $a1 - the column number of the first character
# $a2 - the address of a null-terminated string to print
#DESTROYED:
# $a0
# $a1
# $a2
#SIDE-EFFECTS:
# $a2 will contain the address of the end of the string

.globl console_printstring
console_printstring: pushra
	
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


#reads the next character from the console input and stores it into $v0 
.macro console_readchar
	li $v0, 100
	syscall
.end_macro


#reads from the console until the enter key is pressed
#also displays the current string starting at the given position
#after completion, a null-terminated string will be stored starting at the address stored in $a2
#PARAMETERS:
# $a0 - the row number to start printing from
# $a1 - the column number to start printing from
# $a2 - the address to store the string
# $a3 - the maximum length of the string
#DESTROYED:
# $v0
# $a0
# $a1
# $t0
#SIDE-EFFECTS:
# $a1 will contain the length of the string
.globl console_readline_and_print
console_readline_and_print: pushra
	#first we need to find the character index we are printing to and store it in $a0
	mul $a0, $a0, CONSOLE_CHARS_PER_ROW
	add $a0, $a0, $a1
	# $a0 is the memory offset in the character buffer that we are writing to
	
	li $a1, 0 # $a1 is now the index into the string that the next character will be written to
	
	console_readline_and_print_loop:
		console_readchar
		blez $v0, console_readline_and_print_loop
		
		beq $v0, 8, console_readline_and_print_handlebackspace #user pressed backspace
		beq $v0, 10, console_readline_and_print_handleenter #user pressed enter
		bge $a1, $a3, console_readline_and_print_loop #we are at the maximum length
		
		#else, we need to update the strings and do it all again
		sb $v0, CONSOLE($a0) # write the char to the console
		add $t0, $a1, $a2 # calculate the address of the character in the output string
		sb $v0, ($t0) # store the character into the output string
		addi $a0, $a0, 1 #increment the address and index
		addi $a1, $a1, 1
		j console_readline_and_print_loop #read the next character
	
	console_readline_and_print_handlebackspace:
		blez $a1, console_readline_and_print_loop #if we can't backspace any more
		subi $a1, $a1, 1 #decrement the addresses and indexes
		subi $a0, $a0, 1
		sb $0, CONSOLE($a0) #clear the character in the console
		add $t0, $a1, $a2 #calculate the address of the character to clear
		sb $0, ($t0) #clear the character in the output string
		j console_readline_and_print_loop
		
	console_readline_and_print_handleenter:
		# set the last character of the string to zero
		add $t0, $a1, $a2
		sb $0, ($t0)
		# and return...
console_readline_and_print_return: return
	
	