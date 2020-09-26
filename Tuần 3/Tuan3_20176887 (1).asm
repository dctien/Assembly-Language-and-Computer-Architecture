.data
	A: .word 5 10 15 20 -25
	test: .word 2
.text
	#Assignment 1
#	li $t1,10
#	li $t2,4
#	li $t3,2
#	start:
#		slt $t0,$s2,$s1
#		bne $t0,$zero, else
#		addi $t1,$t1,1
#		addi $t3,$zero,1
#		j endif
#	else: addi $t2,$t2,-1
#	      add $t3,$t3,$t3
#	endif:
	
#	Assignment 2
#	li $s4,1
#	li $s1,-1
#	li $s5,0
#	li $s3,5
#	li $s2,A
#	loop: add $s1,$s1,$s4
#	      add $t1,$s1,$s1
#	      add $t1,$t1,$t1
#	      add $t1,$t1,$s2
#	      lw $t0,0($t1)
#	      add $s5,$s5,$t0
#	      bne $s1,$s3, loop	
	      
#	Assignment 3
#	li $s2,4
#	li $s3,9
#	la $s0, test
#	lw $s1, 0($s0)
#	li $t0,0
#	li $t1,1
#	li $t2,2
#	beq $s1,$t0, case_0
#	beq $s1,$t1, case_1
#	beq $s1,$t2, case_2
#	j default
#case_0: add $s2,$s2,1
#	j continue
#case_1: add $s2,$s2,$t1
#	j continue
#case_2: add $s3,$s3,$s3
#	j continue
#default:
#continue:

#	Assignment 4	
#a. i<j
	slt $t0,$s1,$s2
	bne $t0,$zero, else
#b. i>=j
	slt $t0,$s1,$s2
	bne $t0,$zero, else
#c. i+j <=0
	add $s3,$s1,$s2
	slt $t0,$zero,$s3
	bne $t0,$zero,else
#d. i+j>m+n
	li $t4,2 #m=2
	li $t5,3 #n=3
	add $t6,$t4,$t5
	add $s3,$s1,$s2
	slt $t0,$t6,$s3
	bne $t0,$zero,else
	
#	Assignment 5
#a. i<n
	slt $s6,$s1,$s3
	bne $s6,$zero,loop	
#b. i<=n
	slt $s6,$s3,$s1
	bne $s6,$zero,loop
#c. sum >=0
	slt $s6,$s5,$zero
	bne $s5,$zero,loop

#d. A[i]=0
		
#	Assignment 6
	addi $s1,$zero,0  	
	la $s2,A 	
	addi $s3,$zero,5 	
	addi $s4,$zero,1  	
	addi $s5,$zero,0  	
loop:  
	slt $t2,$s1,$s3  	
	beq $t2,$zero,endloop  
	add $t1,$s1,$s1  
	add $t1,$t1,$t1  
	add $t1,$t1,$s2  
	lw $t0,0($t1)  
	bgtz $t0, if		
	sub $t0, $zero, $t0	

if:
	slt $t6,$s5,$t0 
	beq $t6,$zero,endif 
	add $s5,$zero,$t0 
endif: 
	add $s1,$s1,$s4	
	j loop  
endloop: 
			
	