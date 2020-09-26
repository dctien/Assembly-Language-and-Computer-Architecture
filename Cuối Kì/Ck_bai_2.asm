.eqv SCREEN 	0x10010000	#Dia chi bat dau cua bo nho man hinh (static data)
.eqv YELLOW 	0x00FFFF00
.eqv BLUE 	0x0000FF
.eqv RED 0x00FF0000
.eqv GREEN 0x0000FF00
.eqv BACKGROUND 0x00000000
.eqv KEY_A 	0x00000061
.eqv KEY_S	0x00000073
.eqv KEY_D	0x00000064
.eqv KEY_W	0x00000077
.eqv KEY_ENTER	0x0000000a
.eqv DELTA_X	10
.eqv DELTA_Y	10
.eqv DELAY_TIME	100
.eqv KEY_CODE	0xFFFF0004
.eqv KEY_READY	0xFFFF0000

	
.macro branchIfLessOrEqual(%r1, %r2, %label) 
	sle $v0, %r1, %r2 	#Set register $v0 to 1 if register %r1 is less than  or equal to %r2 and to 0 otherwise.
 	bnez $v0, %label 
.end_macro	
 
.macro setColorAndDrawCirle(%color)
	li $s5, %color	#	Dat mau 
 	jal drawCircle		#	De xoa duong tron cu.
.end_macro  

.macro addToStack3(%r1, %r2, %r3)
	add $sp, $sp, -12
	sw %r1, 0($sp)
	sw %r2, 4($sp)
	sw %r3, 8($sp)
.end_macro

.macro addToStack4(%r1, %r2, %r3, %r4)
	add $sp, $sp, -16
	sw %r1, 0($sp)
	sw %r2, 4($sp) 
	sw %r3, 8($sp)
	sw %r4, 12($sp)
.end_macro

.macro getFromStack3(%r1, %r2, %r3)
	lw %r1, 0($sp)
 	lw %r2, 4($sp)
 	lw %r3, 8($sp)
 	add $sp, $sp, 12
.end_macro

.macro getFromStack4(%r1, %r2, %r3, %r4)
	lw %r1, 0($sp)
 	lw %r2, 4($sp)
 	lw %r3, 8($sp)
 	lw %r4, 12($sp)
 	add $sp, $sp, 16
.end_macro

.data 
	CIRCLE_DATA: 	.space 512
.text
 	li $s0, 256	# Xo = 256		Toa do X cua tam duong tron
 	li $s1, 256	# Yo = 256		Toa do Y cua tam duong tron
 	li $s2, 24	# R = 24 		Ban kinh cua tam duong tron
 	li $s3, 512	# SCREEN_WITH = 512	Be ngang man hinh
 	li $s4, 512	# SCREEN_HEIGHT = 512	Chieu cao man hinh
 selectColor:
 	li $s5, YELLOW		#	Dat mau hinh tron la mau vang
 	mul $s6, $s2, $s2	#	R^2
 	jal circleInit

 gameLoop:
 readKeyboard:
 	lw $k1, KEY_READY       #      kiem tra da nhap phim nao chua  
 	beqz $k1, positionCheck 
 	nop
 	lw $k0, KEY_CODE        #     chua ký tu nhap vao
 	beq $k0, KEY_A, case_a
 	beq $k0, KEY_S, case_s
 	beq $k0, KEY_D, case_d
 	beq $k0, KEY_W, case_w
 	beq $k0, 0x31, case_1
 	beq $k0, 0x32, case_2
 	beq $k0, 0x33, case_3
 	beq $k0, 0x34, case_4
 	beq $k0, KEY_ENTER, case_enter
 	j positionCheck
 case_a:
 	jal moveToLeft
 	j positionCheck
 case_s:
 	jal moveToDown
 	j positionCheck
 case_d:
 	jal moveToRight
 	j positionCheck
 case_w:
 	jal moveToUp
 	j positionCheck
 case_1:
 	li $t9, 1
 	j positionCheck
 case_2:
 	li $t9, 2
 	j positionCheck
 case_3:
 	li $t9, 3
 	j positionCheck
 case_4:
 	li $t9, 4
 	j positionCheck
 case_enter: 
 	j endProgram
 	
 positionCheck:		
 checkRightEdge:
 	add $v0, $s0, $s2	# 
 	add $v0, $v0,$s7	# If Xo + R + DELTA_X > SCREEN_WIDTH Then
 	branchIfLessOrEqual($v0, $s3, checkLeftEdge)	#	moveToLeft
 	jal moveToLeft	#
 	nop
 checkLeftEdge:
 	sub $v0, $s0, $s2	#
 	add $v0, $v0, $s7	# # If Xo - R + DELTA_X < 0 then moveToRight
 	branchIfLessOrEqual($zero, $v0, checkTopEdge)	 	
 	jal moveToRight	#
 	nop
 checkTopEdge:
 	sub $v0, $s1, $s2	#
 	add $v0, $v0, $t8	#
 	branchIfLessOrEqual($zero, $v0, checkBottomEdge)	# If Yo - R + DELTA_Y < 0 then moveToDown
 	jal moveToDown	#
 	nop
 checkBottomEdge:
 	add $v0, $s1, $s2	#
 	add $v0, $v0, $t8	#
 	branchIfLessOrEqual($v0, $s4, draw)	# If Yo + R + DELTA_Y > SCREEN_HEIGHT then
 	jal moveToUp	#
 	nop


 		
 draw: 	
 	setColorAndDrawCirle(BACKGROUND) # Ve duong tron trung mau nen
 	add $s0, $s0, $s7	#	Cap nhat toa do moi
 	add $s1, $s1, $t8	#	cua duong tron
 
 	beq $t9, 1, set_1
 	beq $t9, 2, set_2
 	beq $t9, 3, set_3
 	beq $t9, 4, set_4
 set_1:
 	setColorAndDrawCirle(YELLOW) # Ve duong tron moi
 	j after_set
 set_2:
 	setColorAndDrawCirle(GREEN) # Ve duong tron moi
 	j after_set
 set_3:
 	setColorAndDrawCirle(BLUE) # Ve duong tron moi
 	j after_set
 set_4:
 	setColorAndDrawCirle(RED) # Ve duong tron moi
 	j after_set
 after_set:
 	#delay
 	li $a0, DELAY_TIME
 	li $v0, 32
 	syscall
 	j gameLoop
 	
endProgram:
	setColorAndDrawCirle(BACKGROUND)
 	li $v0, 10
 	syscall
 
 	
 #	Ham khoi dong duong tron
 # 	Tao mang du lieu luu toa do cac diem cua duong tron
circleInit: 
	addToStack4($ra, $t0, $t3, $t5)

	li $t0, 0		# i = 0
	la $t5, CIRCLE_DATA  
loop:	slt $v0, $t0, $s2    	# i -> R
	beqz $v0, end_circleInit 
	mul $t3, $t0, $t0	# i^2
	sub $t3, $s6, $t3	# $t3 = R^2 - i^2
	move $v0, $t3  		# Move the contents of $t3 to $v0.
	jal sqrt
	sw $a0, 0($t5)		# Luu j = sqrt(R^2 - i^2) vao mang du lieu
	 
	addi $t0, $t0, 1
	add $t5, $t5, 4
	j loop
end_circleInit:
	getFromStack4($ra, $t0, $t3, $t5)
	jr $ra
 
 
#
#	Ham ve diem tren duong tron
# 	Ve dong thoi 2 diem (X0 + i, Y0 +j ) va (Xo + j, Xo + i)
#	@param i = $a0, j = $a1
 drawCirclePoint:
 	addToStack3($t1, $t2, $t4)

 	
 	add $t1, $s0, $a0 	# Xi = Xo + i
	add $t4, $s1, $a1	# Yi = Y0 + j
	mul $t2, $t4, $s3	# Yi * SCREEN_WITH
	add $t1, $t1, $t2	# Yi * SCREEN_WITH + Xi (Toa do 1 chieu cua diem anh)
	sll $t1, $t1, 2	 	# Dia chi tuong doi cua diem anh
	sw $s5, SCREEN($t1) 	# Draw anh  
	
	getFromStack3($t1, $t2, $t4)
	jr $ra
 
#	Ham ve duong tron
#	Su dung du lieu o mang CIRCLE_DATA tao boi ham khoidong_Duong tron	
 drawCircle:

	addToStack3($ra, $t0, $t3)
 	li $t0, 0	# int i = 0
 loop_drawCircle:
  	slt $v0, $t0, $s2  
 	beqz $v0,  end_drawCircle 
	
	sll $t1, $t0, 2   
	lw $t3, CIRCLE_DATA($t1) # Load j to $t3	 
	
 	move $a0, $t0	# $a0 = i
	move $a1, $t3	# $a1 = j
	jal drawCirclePoint	# Draw (Xo + i, Yo + j), (Xo + j, Yo + i)
	sub $a1, $zero, $t3 
	jal drawCirclePoint	# Draw (Xo + i, Yo - j), (Xo + j, Yo - i)
	sub $a0, $zero, $t0
	jal drawCirclePoint	# Draw (Xo - i, Yo - j), (Xo - j, Yo - i)
	add $a1, $zero, $t3
	jal drawCirclePoint	# Draw (Xo - i, Yo + j), (Xo - j, Yo + i)
	
	addi $t0, $t0, 1
	j loop_drawCircle
 end_drawCircle:
 
	getFromStack3($ra, $t0, $t3)	
 	jr $ra


 				
 				 				
 # Ham tinh can bac hai				 				 				 				
 # $v0 = S, $a0 = sqrt(S)
sqrt: 
	mtc1 $v0, $f0         # Move to Coproc 1
	cvt.s.w $f0, $f0   	# Convert from word to single precision (floating-point format)
	sqrt.s $f0, $f0  	# Square root single precision
	cvt.w.s $f0, $f0
	mfc1 $a0, $f0  
	jr $ra



#	Cac ham di chuyen
moveToLeft:
	li $s7, -DELTA_X
 	li $t8, 0
	jr $ra 	
moveToRight:
	li $s7, DELTA_X
 	li $t8, 0
	jr $ra 	
moveToUp:
	li $s7, 0
 	li $t8, -DELTA_Y
	jr $ra 	
moveToDown:
	li $s7, 0
 	li $t8, DELTA_Y
	jr $ra 
 
 
