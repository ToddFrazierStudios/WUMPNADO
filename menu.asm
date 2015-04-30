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

room:
.asciiz "You are now in room "

wdeath:
.asciiz "You were eaten by a wumpus."

pdeath:
.asciiz "You fell into a pit."

wumpnado:
.asciiz "Wumpnado incoming!"
.text

menu:
	
	jal initializemap
	
menuloop:
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
	return
	
checkwest:
	pushra
	lw $t3, player
	addi $a0, $t3, 8
	jal get
	
	li $t0, 1
	li $t1, 2
	li $t2, 3
	beq $a0, $t0, nearwumpus
	beq $a0, $t1, nearpit
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
	
analyzereturn:
	return
finish:
	END_PROGRAM
