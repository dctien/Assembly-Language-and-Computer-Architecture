.eqv SEVENSEG_LEFT 0xFFFF0011  #Dia chi cua den led 7 doan trai.
				# Bit 0 = doan a; 
				# Bit 1 = doan b; ... 
				# Bit 7 = dau .
			
.eqv SEVENSEG_RIGHT 0xFFFF0010 # Dia chi cua den led 7 doan phai
.text

main:
	li $t2,0     
Loop:
	slti $t1,$t2,100
	addi $t4,$t2,0
	beq $t1,$0,Done
	li $t3,10
	div $t4,$t3
	mflo $t4
	mfhi $t3
	
	bne $t3,0,end_so0
	li    $a0, 0x3F 
	jal   SHOW_7SEG_RIGHT          # show  
	j Right           # set value for segments
end_so0:
	bne $t3,1,end_so1
	li    $a0, 0x6 
	jal   SHOW_7SEG_RIGHT          # show 
	nop  
	j Right 
end_so1:
	bne $t3,2,end_so2
	li    $a0, 0x5B 
	jal   SHOW_7SEG_RIGHT          # show 
	nop  
	j Right 
end_so2:
	bne $t3,3,end_so3
	li    $a0, 0x4F 
	jal   SHOW_7SEG_RIGHT          # show 
	nop  
	j Right 
end_so3:
	bne $t3,4,end_so4
	li    $a0, 0x66 
	jal   SHOW_7SEG_RIGHT          # show 
	nop  
	j Right 
end_so4:
	bne $t3,5,end_so5
	li    $a0, 0x6D 
	jal   SHOW_7SEG_RIGHT          # show 
	nop  
	j Right 
end_so5:
	bne $t3,6,end_so6
	li    $a0, 0x7D 
	jal   SHOW_7SEG_RIGHT          # show 
	nop  
	j Right 
end_so6:
	bne $t3,7,end_so7
	li    $a0, 0x7 
	jal   SHOW_7SEG_RIGHT          # show 
	nop  
	j Right 
end_so7:
	bne $t3,8,end_so8
	li    $a0, 0x7F 
	jal   SHOW_7SEG_RIGHT          # show 
	nop  
	j Right 
end_so8:
	bne $t3,9,end_so9
	li    $a0, 0x6F 
	jal   SHOW_7SEG_RIGHT         # show 
	nop  
	j Right 
end_so9:


Right:
bne $t4,0,end_so00
	li    $a0, 0x3F 
	jal   SHOW_7SEG_LEFT          # show  
	j Left           # set value for segments
end_so00:
	bne $t4,1,end_so01
	li    $a0, 0x6 
	jal   SHOW_7SEG_LEFT          # show 
	nop  
	j Left  
end_so01:
	bne $t4,2,end_so02
	li    $a0, 0x5B 
	jal   SHOW_7SEG_LEFT          # show 
	nop  
	j Left  
end_so02:
	bne $t4,3,end_so03
	li    $a0, 0x4F 
	jal   SHOW_7SEG_LEFT        # show 
	nop  
	j Left  
end_so03:
	bne $t4,4,end_so04
	li    $a0, 0x66 
	jal   SHOW_7SEG_LEFT          # show 
	nop  
	j Left  
end_so04:
	bne $t4,5,end_so05
	li    $a0, 0x6D 
	jal   SHOW_7SEG_LEFT          # show 
	nop  
	j Left  
end_so05:
	bne $t4,6,end_so06
	li    $a0, 0x7D 
	jal   SHOW_7SEG_LEFT          # show 
	nop  
	j Left  
end_so06:
	bne $t4,7,end_so07
	li    $a0, 0x7 
	jal   SHOW_7SEG_LEFT          # show 
	nop  
	j Left  
end_so07:
	bne $t4,8,end_so08
	li    $a0, 0x7F 
	jal   SHOW_7SEG_LEFT          # show 
	nop  
	j Left  
end_so08:
	bne $t4,9,end_so09
	li    $a0, 0x6F 
	jal   SHOW_7SEG_LEFT         # show 
	nop  
	j Left  
end_so09:
Left:
li $t5,0
Delay:
	beq $t5,100,End_delay
	addi $t5,$t5,1
	j Delay
End_delay:
addi       $t2,$t2,1

     j Loop   
Done:
exit:     li    $v0, 10 
	  syscall 
endmain: 
SHOW_7SEG_LEFT:  
	li   $t0,  SEVENSEG_LEFT # assign port's address 
	sb   $a0,  0($t0) 
        nop              
        jr   $ra
        nop   
SHOW_7SEG_RIGHT:  
	li   $t0,  SEVENSEG_RIGHT # assign port's address 
	sb   $a0,  0($t0) 
        nop              
        jr   $ra
        nop   