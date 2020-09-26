.data 
	count: .word 5
	array: .word  10 1 2 9 12 
.text 
	lw $a0, count 	
	la $a1, array 	
	jal sort

sort:
	li $t7, 0 		 	 
swapLoop:   
	move $t6, $a0 	 	
	subi $t6, $t6, 1 	
	li $t7, 1 		
loop:
	beq $t6, $zero, swapLoop	
	subi $t5, $t6, 1 		
	mul $t0, $t6, 4 		
	mul $t1, $t5, 4 		 
	add $t2, $t0, $a1 	
	add $t3, $t1, $a1
	lw $t4, ($t2)		
	lw $t5, ($t3)	  
	blt $t4, $t5, swap	
	
	subi $t6, $t6, 1 		
	j loop			

swap: 
	sw  $t5, 0($t2) 			
	sw  $t4, 0($t3)			
	subi $t6, $t6, 1 		
	li $t7, 0 			
	j loop		

exit: 
	li $v0, 10  	
	syscall
