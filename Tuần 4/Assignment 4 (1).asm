.text
start: 
	li $s1,50
	li $s2,-25
	li $t0,0
	addu $s3,$s1,$s2
	xor $t1,$s1,$s2
	
	bltz $t1,EXIT
	xor $t2,$s3,$s1
	bltz $t2,OVERFLOW
	j EXIT
OVERFLOW:
	li $t0,1
EXIT: