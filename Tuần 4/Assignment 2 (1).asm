.text
	li $s0,0x12345678
#	addi $t0,$s0,0xff000000
#	srl $t0,$t0,24
#	add $t0,$t0,0x1
	

#	li $s0,0x12345678
#	andi $s0,$s0,0xffffff00
#	ori $s0,$s0,0x000000ff

#	li $s1,0x000000ff
#	or $t2,$s0,$s2
	
	li $s3,0xffffffff
	nor $s0,$s0,$s3