.data
	message: .asciiz "The sum of "
	message2: .asciiz " and "
	message3: .asciiz " is "
.text
	li $t1, 1
	li $t2, 2
	add $t3,$t1,$t2
	li $v0,4
	la $a0,message
	syscall
	addi $a0,$t1,0
	li $v0,1
	syscall
	li $v0,4
	la $a0,message2
	syscall
	li $v0,1
	addi $a0,$t2,0
	syscall 
	li $v0,4
	la $a0,message3
	syscall
	li $v0,1
	add $a0,$t3,0
	syscall
	