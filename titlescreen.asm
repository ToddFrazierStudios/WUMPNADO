.include "macros.asm"

.data
pressanykeymsg: .asciiz "Press any key to continue"
pressanykeyclr: .asciiz "                         "

beginmsg: .asciiz "Press any key to begin"
beginclr: .asciiz "                      "

entermsg: .asciiz "You step into the cave"
dotmsg: .asciiz "."
enterclr: .asciiz "                         "

goodluckmsg: .asciiz "Good luck."
goodluckclr: .asciiz "          "

.text
.globl main
main:
	li $a0, 0
	li $a1, 0
	la $a2, screen_logo
	jal console_printstring
	
	animationloop:
	li $a0, 19
	li $a1, 27
	la $a2, pressanykeymsg
	jal console_printstring

	delay 400
	
	li $a0, 19
	li $a1, 27
	la $a2, pressanykeyclr
	jal console_printstring
	
	delay 400
	
	li $v0, 100
	syscall
	blez $v0, animationloop
		
	beq $v0, 113, finish
	beq $v0, 104, drawhelpscreen
	
	j startgame	


drawhelpscreen:
	li $a0, 0
	li $a1, 0
	la $a2, screen_help
	jal console_printstring
	
	helpanimationloop:
	li $a0, 23
	li $a1, 29
	la $a2, beginmsg
	jal console_printstring

	delay 400
	
	li $a0, 23
	li $a1, 29
	la $a2, beginclr
	jal console_printstring
	
	delay 400
	
	li $v0, 100
	syscall
	blez $v0, helpanimationloop
	
	j startgame
	
startgame:
	jal console_clear
	
	li $a0, 12
	li $a1, 28
	la $a2, entermsg
	jal console_printstring
	
	delay 300
	
	li $a0, 12
	li $a1, 50
	la $a2, dotmsg
	jal console_printstring
	delay 300
	
	li $a0, 12
	li $a1, 51
	la $a2, dotmsg
	jal console_printstring
	delay 300
	
	li $a0, 12
	li $a1, 52
	la $a2, dotmsg
	jal console_printstring
	delay 800
	
	li $a0, 13
	li $a1, 47
	la $a2, goodluckmsg
	jal console_printstring
	delay 800
	
	li $a0, 12
	li $a1, 28
	la $a2, enterclr
	jal console_printstring
	
	li $a0, 13
	li $a1, 47
	la $a2, goodluckclr
	jal console_printstring
	
	j menu
	
	li $a0, 0
	li $a1, 0
	la $a2, screen_gameover_pit
	jal console_printstring
	
	waitforinput:
	li $v0, 100
	syscall
	blez $v0, waitforinput
	
	li $a0, 0
	li $a1, 0
	la $a2, screen_gameover_eaten
	jal console_printstring
	
	waitforinput2:
	li $v0, 100
	syscall
	blez $v0, waitforinput2
	
	li $a0, 0
	li $a1, 0
	la $a2, screen_gameover_win
	jal console_printstring
	
	
finish:
	jal console_clear
	END_PROGRAM
