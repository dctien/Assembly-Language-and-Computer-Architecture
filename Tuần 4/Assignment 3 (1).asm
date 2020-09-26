.text
#a
#	li $s1,-10
#	slt $t0,$s1,$zero
#	beq $t0,$zero,EXIT
#	sub $s0,$zero,$s1
#EXIT:
	
#b	
#	li $s1,10
#	add $s0,$s1,$zero

#c
#	li $s0,20
#	not $s0,$s0
	
#d
	li $s1,10
	li $s2,20
	slt $t0,$s2,$s1
	beq $t0,$zero,L
	li $s3,1
	j EXIT
L:
	li $s3,0
EXIT:
	