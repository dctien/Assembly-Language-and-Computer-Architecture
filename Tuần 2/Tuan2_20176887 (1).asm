.data
	X: .word 5
	Y: .word -1
	Z: .word
.text
	#Assignment 1
	#addi $t1,$zero,16
	#add $t2,$zero,$t1
	
	#Assignment 2
	#lui $s0,0x1AB
	#ori $s0,$s0,0x003d
	
	#Assignment 3
	#li $s0, 0x123BC12d
	#li $s1, 128
	
	#Assignment 4
	#addi $s0, $zero, 9
	#addi $s1, $zero, 12
	
	#add $t1,$s0,$s0
	#add $t1,$t1,$s1
	
	#Assignment 5
	#addi $t1, $zero, 9
	#addi $t2, $zero, 10
	
	#mul $s0,$t1,$t2
	#mul $s0,$s0,10
	#mflo $s1
	
	#Assignment 6
	la $t8,X
	la $t9,Y
	lw $t1,0($t8)
	lw $t2,0($t9)
	
	add $s0,$t1,$t1
	add $s0,$s0,$t2
	
	la $t7,Z 
	sw $s0,0($t7)
	
	
	