# Map creation and manipulation

.data

n:	.asciiz "\n"
map:	.word 0:64 # 0 for blank, 1 for wumpus, 2 for pit, 3 for gold, 4 for player

.text 

main:
	
	# Get system time to seed random number generator
	li $v0, 30
	syscall
	
	# Random number generator seeding
	# Random number generator's id is 1
	li $v0, 40
	add $a1, $a0, $0
	li $a0, 1
	syscall
	
	li $a0, 0
	li $a1, 10
	li $a2, 10
	j generatemap
	
# Fill the map with monsters
generatemap: #(a0 the position of player, a1 the number of wumpus, a2 the number of pits)
	
	# s0 is the map's address
	la $s0, map
	
	add $s4, $0, $a0
	add $s5, $0, $a1
	add $s6, $0, $a2
	
	# place player in room 0
	li $t2, 4
	mul $t1, $s4, 4
	add $t1, $t1, $s0
	sw $t2, ($t1)
	
	# create 10 wumpus
	li $a0, 1
	add $a1, $0, $s5
	jal generatemonster
	
	# create 10 pits
	li $a0, 2
	add $a1, $0, $s6
	jal generatemonster
	
	# generate the gold
	li $a0, 3
	li $a1, 1
	jal generatemonster
	
	jal printmap
	
	j finish
	
generatemonster: #($a0: the monster's number, $a1: the amount to place)
	
	sw $ra, ($sp)
	subi $sp, $sp, 4
	
	# s1 is the monster we want
	add $s1, $0, $a0
	
	# s2 is how many we want
	add $s2, $0, $a1
	
gmloop:
	
	# get a random spot for the monster between 0 and 64
	li $v0, 42
	li $a0, 1
	li $a1, 65
	syscall
	
	add $s3, $a0, $0
	
	# print index
	li $v0, 1
	#syscall
	
	# new line
	li $v0, 4
	la $a0, n
	#syscall
	
	# store what's in the array in t2
	jal get
	#lw $a0, ($a0)
	
	# if the place in the map is not empty, try again
	#bnez $a0, gmloop
	
	# if the array element is zero, store the monster
	add $a1, $s1, $0
	add $a0, $s3, $0
	jal store
	
	# loop stuff
	addi $s2, $s2, -1
	
	bnez $s2, gmloop
	
	# return
	addi $sp, $sp, 4
	lw $t0, ($sp)
	jr $t0
	
get:	#($a0: the index of the array)
	# after execution, $a0 stores the value of the element in the array
	
	sw $ra, ($sp)
	subi $sp, $sp, 4
	
	add $t0, $a0, $0
	
	# move to the spot in the array
	mul $t1, $t0, 4
	add $t0, $t1, $s0
	
	# a0 holds the value of that spot in the array
	add $a0, $t0, $0
	#lw $a0, ($t0)
	
	# return
	addi $sp, $sp, 4
	lw $t0, ($sp)
	jr $t0

store: #($a0: the index of the array, $a1: the value to store)
	
	sw $ra, ($sp)
	subi $sp, $sp, 4
	
	mul $t0, $a0, 4
	add $t1, $t0, $s0
	sw $a1, ($t1)
	
	# return
	addi $sp, $sp, 4
	lw $t0, ($sp)
	jr $t0	

# uses s4 and s5
printmap:
	
	# store return address
	sw $ra, ($sp)
	subi $sp, $sp, 4
	
	# loop counter
	li $s4, 64
	li $s5, 0
	li $s6, 8
	
pmloop:
	# print the int
	li $v0, 1
	add $a0, $s5, $0
	jal get
	lw $a0, ($a0)
	syscall
	
	li $v0, 11
	li $a0, 32
	syscall
	
	addi $s5, $s5, 1
	subi $s4, $s4, 1
	subi $s6, $s6, 1
	bnez $s6, pmloop
	
	# new line
	li $v0, 4
	la $a0, n
	syscall
	li $s6, 8
	bnez $s4, pmloop
	
	# return
	addi $sp, $sp, 4
	lw $t0, ($sp)
	jr $t0
	
wumpnado: #(a0 the index of the player, a1 the amount of wumpus, a2 the amount of pits)
	li $a0, 0
	li $a1, 10
	li $a2, 10
	j generatemap
	
north:

south:

east:

west: 
	
finish:
	li $v0, 10
	syscall
