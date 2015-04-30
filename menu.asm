.include "macros.asm"

.data
.globl choice, northtext, southtext, westtext, easttext

choice: .asciiz "North"

line: .word 0

head: 
.asciiz "Choose an action:"

northtext:
.asciiz "north"
southtext:
.asciiz "south"
westtext:
.asciiz "west"
easttext:
.asciiz "east"
quittext:
.asciiz "quit"
choose:
.asciiz "Enter your choice: "

wumpus:
.asciiz "You smell a wumpus."

pit:
.asciiz "You feel a breeze."

gold:
.asciiz "You see something shiny."

room:
.asciiz "You are now in room "

wdeath:
.asciiz "You were eaten by a wumpus."

pdeath:
.asciiz "You fell into a pit."

gdeath:
.asciiz "You found the gold!"

wumpnadotext:
.asciiz "Wumpnado incoming!"
.text

menu:
	
	jal initializemap
	
menuloop:

	lw $t0, wcounter
	
	# print the countdown
	li $v0, 1
	addi $a0, $t0, 0
	syscall
	# new line
	li $v0, 4
	la $a0, n
	syscall
	
	bnez $t0, loop
	jal wumpnado

loop:
	lw $t0, wcounter
	subi $t0, $t0, 1
	sw $t0, wcounter
	lw $a0, line
	addi $s6, $a0, 0
	li $a1, 0
	la $a2, room
	jal console_printstring
	sw $s6, line
	
	lw $a0, line
	addi $s6, $a0, 1
	li $a1, 20
	lw $a2, player
	jal console_printint
	addi $a0, $a0, 1
	sw $s6, line
	
	jal analyzeenv

	lw $a0, line
	addi $s6, $a0, 1
	li $a1, 0
	la $a2, head
	jal console_printstring
	sw $s6, line
	
	lw $a0, line
	addi $s6, $a0, 1
	li $a1, 0
	la $a2, northtext
	jal console_printstring
	sw $s6, line
	
	lw $a0, line
	addi $s6, $a0, 1
	li $a1, 0
	la $a2, southtext
	jal console_printstring
	sw $s6, line
	
	lw $a0, line
	addi $s6, $a0, 1
	li $a1, 0
	la $a2, westtext
	jal console_printstring
	sw $s6, line
	
	lw $a0, line
	addi $s6, $a0, 1
	li $a1, 0
	la $a2, easttext
	jal console_printstring
	sw $s6, line
	
	lw $a0, line
	addi $s6, $a0, 1
	li $a1, 0
	la $a2, quittext
	jal console_printstring
	sw $s6, line

	lw $a0, line
	addi $s6, $a0, 1
	li $a1, 0
	la $a2, choose
	jal console_printstring
	sw $s6, line
	
	lw $a0, line
	addi $s6, $a0, 1
	li $a1, 0
	la $a2, choice
	li $a3, 5
	jal console_readline_and_print
	sw $s6, line
	
	jal analyzechoice
	
	jal console_clear
	
	li $s6, 0
	sw $s6, line
	li $t0, 1
	lw $t1, wcounter
	beq $t0, $t1, wincoming
	j menuloop
	
analyzechoice:
	pushra
	
	la $a0, choice
	la $a1, northtext
	jal comparestr
	
	beqz $v0, movenorth
	
	la $a0, choice
	la $a1, southtext
	jal comparestr
	
	beqz $v0, movesouth
	
	la $a0, choice
	la $a1, westtext
	jal comparestr
	
	beqz $v0, movewest
	
	la $a0, choice
	la $a1, easttext
	jal comparestr
	
	beqz $v0, moveeast
	
	la $a0, choice
	la $a1, quittext
	jal comparestr
	
	
	beqz $v0, finish
	
	return
	
movenorth:
	
	jal north
	return
	
movesouth:
	jal south
	return
	
movewest:
	jal west
	return

moveeast:
	jal east
	return

analyzeenv:
	pushra
	jal checknorth
	jal checksouth
	jal checkeast
	jal checkwest
	j analyzereturn
	
checknorth:
	pushra
	lw $t3, player
	subi $a0, $t3, 8
	jal get
	
	li $t0, 1
	li $t1, 2
	li $t2, 3
	beq $a0, $t0, nearwumpus
	beq $a0, $t1, nearpit
	beq $a0, $t2, neargold
	return
	
checksouth:
	pushra
	lw $t3, player
	addi $a0, $t3, 8
	jal get
	
	li $t0, 1
	li $t1, 2
	li $t2, 3
	beq $a0, $t0, nearwumpus
	beq $a0, $t1, nearpit
	beq $a0, $t2, neargold
	return
	
checkeast:
	pushra
	
	lw $t3, player
	li $t4, 8
	addi $t5, $t3, 1
	add $a0, $t5, $0
	div $t5, $t4
	mfhi $t5
	beqz $t5, checkeastreturn
	
	jal get
	
	li $t0, 1
	li $t1, 2
	li $t2, 3
	beq $a0, $t0, nearwumpus
	beq $a0, $t1, nearpit
	beq $a0, $t2, neargold
	
checkeastreturn:
	return
	
checkwest:
	pushra
	
	lw $t3, player
	li $t4, 8
	subi $a0, $t3, 1
	div $t3, $t4
	mfhi $t3
	beqz $t3, checkwestreturn
	
	jal get
	
	li $t0, 1
	li $t1, 2
	li $t2, 3
	beq $a0, $t0, nearwumpus
	beq $a0, $t1, nearpit
	beq $a0, $t2, neargold
	
checkwestreturn:
	return
	
nearwumpus:
	lw $a0, line
	addi $s6, $a0, 1
	li $a1, 0
	la $a2, wumpus
	jal console_printstring
	sw $s6, line
	j analyzereturn
	
nearpit:
	lw $a0, line
	addi $s6, $a0, 1
	li $a1, 0
	la $a2, pit
	jal console_printstring
	sw $s6, line
	j analyzereturn
	
neargold:
	lw $a0, line
	addi $s6, $a0, 1
	li $a1, 0
	la $a2, gold
	jal console_printstring
	sw $s6, line
	j analyzereturn
	
analyzereturn:
	return

.globl hitwumpus, fellpit, foundgold	
hitwumpus:
	lw $a0, line
	addi $s6, $a0, 1
	li $a1, 0
	la $a2, wdeath
	jal console_printstring
	sw $s6, line
	j finish

fellpit:
	lw $a0, line
	addi $s6, $a0, 1
	li $a1, 0
	la $a2, pdeath
	jal console_printstring
	sw $s6, line
	j finish

foundgold:
	lw $a0, line
	addi $s6, $a0, 1
	li $a1, 0
	la $a2, gdeath
	jal console_printstring
	sw $s6, line
	j finish
	
wincoming:

	lw $a0, line
	addi $s6, $a0, 1
	li $a1, 0
	la $a2, wumpnadotext
	jal console_printstring
	sw $s6, line
	j menuloop

finish:
	END_PROGRAM
