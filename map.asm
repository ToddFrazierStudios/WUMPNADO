# Map creation and manipulation

.data

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
	
	j generatemap
	
# Fill the map with monsters
generatemap:
	
	# s0 is the map's address
	la $s0, map
	
	# place player in room 0
	li $t1, 4
	sw $t1, ($s0)
	
	# create 10 wumpus
	li $a0, 1
	li $a1, 10
	jal generatemonster
	
	# create 10 pits
	li $a0, 2
	li $a1, 10
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
	li $v0, 41
	li $a0, 1
	li $a1, 65
	syscall
	
	# store what's in the array in t2
	jal get
	add $t2, $a0, $0
	
	# if the place in the map is not empty, try again
	bnez $t2, gmloop
	
	# if the array element is zero, store the monster
	add $a1, $s1, $0
	add $a0, $t0, $0
	jal store
	
	# loop stuff
	addi $s2, $s2, -1
	
	bnez $s2, gmloop
	
	# return
	addi $sp, $sp, 4
	lw $t0, ($sp)
	li $v0, 1
	add $a0, $t0, $0
	syscall
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
	
	# return
	addi $sp, $sp, 4
	lw $t0, ($sp)
	jr $t0

store: #($a0: the index of the array, $a1: the value to store)
	
	sw $ra, ($sp)
	subi $sp, $sp, 4
	
	mul $t0, $a0, 4
	add $t0, $t0, $s0
	sw $a1, ($t0)
	
	# return
	addi $sp, $sp, 4
	lw $t0, ($sp)
	jr $t0	

printmap:
	
	# store return address
	sw $ra, ($sp)
	subi $sp, $sp, 4
	
	# loop counter
	li $t0, 0
	
pmloop:
	# print the int
	li $v0, 1
	add $a0, $t0, $0
	jal get
	syscall
	
	addi $t0, $t0, 1
	subi $t1, $t0, 64
	bnez $t1, pmloop
	
	# return
	addi $sp, $sp, 4
	lw $t0, ($sp)
	jr $t0
	
finish:
	li $v0, 10
	syscall
	