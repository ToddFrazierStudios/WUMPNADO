.include "macros.asm"

.data

tophalf: 
.ascii  "--------------------------------------------------------------------------------" #line 1
.ascii  "                                                                                "
.ascii  "        #     # #     # #     # ######  #     #    #    ######  #######         "
.ascii  "        #  #  # #     # ##   ## #     # ##    #   # #   #     # #     #         "
.ascii  "        #  #  # #     # # # # # #     # # #   #  #   #  #     # #     #         " #line 5
.ascii  "        #  #  # #     # #  #  # ######  #  #  # #     # #     # #     #         "
.ascii  "        #  #  # #     # #     # #       #   # # ####### #     # #     #         "
.ascii  "        #  #  # #     # #     # #       #    ## #     # #     # #     #         "
.ascii  "         ## ##   #####  #     # #       #     # #     # ######  #######         "
.ascii  "                                                                                " #line 10
.ascii  "--------------------------------------------------------------------------------"
.ascii  "                                                                                "
.ascii  "                  A work of true art by Todd Frazier Studios.                   "
.ascii  "                                                                                "
.asciiz "--------------------------------------------------------------------------------" #line 15

bottomhalf:
.ascii  "                                                                                "
.ascii  "                                                                                "
.ascii  "                       _________________________________                        "
.ascii  "                      |                                 |                       "
.ascii  "                      |    Press any key to continue    |                       " #line 20
.ascii  "                      |_________________________________|                       "
.ascii  "                                                                                "
.ascii  "                                                                                "
.ascii  "                                                                                "
.asciiz "                                                                                " #line 25

bottomhalf2: 
.ascii  "                                                                                "
.ascii  "                                                                                "
.ascii  "                       _________________________________                        "
.ascii  "                      |                                 |                       "
.ascii  "                      |                                 |                       " #line 20
.ascii  "                      |_________________________________|                       "
.ascii  "                                                                                "
.ascii  "                                                                                "
.ascii  "                                                                                "
.asciiz "                                                                                " #line 25

.text
.globl main
main:
	li $a0, 0
	li $a1, 0
	la $a2, tophalf
	jal console_printstring
	
	animationloop:
	li $a0, 15
	li $a1, 0
	la $a2, bottomhalf
	jal console_printstring

	delay 400
	
	li $a0, 15
	li $a1, 0
	la $a2, bottomhalf2
	jal console_printstring
	
	delay 400
	
	li $v0, 100
	syscall
	blez $v0, animationloop
		
	jal console_clear
	
	END_PROGRAM