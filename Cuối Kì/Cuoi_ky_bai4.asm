#Mars Bot
.eqv HEADING 0xffff8010 	# Integer: An angle between 0 and 359
				# 0 : North (up)
				# 90: East (right)
				# 180: South (down)
				# 270: West (left)
.eqv MOVING 0xffff8050		# Boolean: whether or not to move
.eqv LEAVETRACK 0xffff8020 	# Boolean (0 or non-0):
				# whether or not to leave a track
.eqv WHEREX 0xffff8030		#Integer: Current x-location of MarsBot
.eqv WHEREY 0xffff8040		# Integer: Current y-location of MarsBot
# Key matrix  
.eqv OUT_ADDRESS_HEXA_KEYBOARD 0xFFFF0014
.eqv IN_ADDRESS_HEXA_KEYBOARD 0xFFFF0012

.data
# script: 'rotate','time','untrack'/'track'; ('untrack' = 0, 'track' = 1)
# postscript 1: DCE => numkey 0
script1: .asciiz "90,2000,0;180,3000,0;180,5790,1;80,500,1;70,500,1;60,500,1;50,500,1;40,500,1;30,500,1;20,500,1;10,500,1;0,500,1;350,500,1;340,500,1;330,500,1;320,500,1;310,500,1;300,500,1;290,500,1;280,490,1;90,7000,0;270,500,1;260,500,1;250,500,1;240,500,1;230,500,1;220,500,1;210,500,1;200,500,1;190,500,1;180,500,1;170,500,1;160,500,1;150,500,1;140,500,1;130,500,1;120,500,1;110,500,1;100,500,1;90,1000,1;90,4000,0;270,2400,1;0,5800,1;90,2400,1;180,2900,0;270,2400,1;90,3000,0;"
# postscript 2: THOR => numkey 4
script2: .asciiz "90,3000,0;180,8000,0;0,6000,1;270,2500,0;90,5000,1;90,2000,0;180,6000,1;0,3000,0;90,3400,1;180,3000,1;0,6000,1;90,4650,0;270,500,1;260,500,1;250,500,1;240,500,1;230,500,1;220,500,1;210,500,1;200,500,1;190,500,1;180,500,1;170,500,1;160,500,1;150,500,1;140,500,1;130,500,1;120,500,1;110,500,1;100,500,1;90,1000,1;80,500,1;70,500,1;60,500,1;50,500,1;40,500,1;30,500,1;20,500,1;10,500,1;0,500,1;350,500,1;340,500,1;330,500,1;320,500,1;310,500,1;300,500,1;290,500,1;280,500,1;270,500,1;90,5000,0;180,6000,1;0,6000,0;90,310,1;100,310,1;110,310,1;120,310,1;130,310,1;140,310,1;150,310,1;160,310,1;170,310,1;180,310,1;190,310,1;200,310,1;210,310,1;220,310,1;230,310,1;240,310,1;250,310,1;260,310,1;270,310,1;130,3900,1;180,700,0;"
# postscript 3: TIEN => numkey 8
script3: .asciiz "90,3000,0;180,6500,0;0,6000,1;270,2500,0;90,5000,1;90,1500,0;180,6000,1;90,1500,0;90,2700,1;270,2700,0;0,3100,1;90,2500,1;270,2500,0;0,2900,1;90,2700,1;90,1500,0;180,6000,1;0,6000,0;153,6750,1;0,6000,1;90,1000,0;"
error: .asciiz "Draw done!"
.text
# <--Keymatrix-->
#------------------------------------------------------ 
#  col	       0x1    	 0x2   	    0x4         0x8  
#  row 0x1      0         1          2           3            
#             0x11      0x21        0x41        0x81    
#  row 0x2      4         5          6           7 
#             0x12      0x22        0x42        0x82  
#  row 0x4      8         9          a           b  
#             0x14      0x24        0x44        0x84  
#  row 0x8      c         d          e           f 
#             0x18      0x28        0x48        0x88  
#------------------------------------------------------
Keymatrix:
	li $t3, IN_ADDRESS_HEXA_KEYBOARD 	# Address of In address
	li $t4, OUT_ADDRESS_HEXA_KEYBOARD 	# Address of Out address
	polling: 
		li $t5, 0x1 			# row-1 of key matrix
		sb $t5, 0($t3) 			# Gan vao address
		lb $a0, 0($t4) 			# Assign numkey to $a0
		bne $a0, 0x11, NOT_NUMKEY_0	# If In address is not numkey '0' -> check numkey '4' or '8'?
		la $a1, script1		# Add script 1 to $a1
		j START_DRAW				
		NOT_NUMKEY_0:
		li $t5, 0x2 			# row-2 of key matrix
		sb $t5, 0($t3)
		lb $a0, 0($t4)
		bne $a0, 0x12, NOT_NUMKEY_4	# If In address is not numkey '4' -> check numkey '8'?
		la $a1, script2
		j START_DRAW
		NOT_NUMKEY_4:
		li $t5, 0X4 			# row-3 of key matrix
		sb $t5, 0($t3)
		lb $a0, 0($t4)
		bne $a0, 0x14, COME_BACK	# If In address is not numkey '8' -> show error dialog, end program
		la $a1, script3
		j START_DRAW
	COME_BACK:
		j Keymatrix 			# khi cac so 0,4,8 khong duoc chon -> quay lai doc tiep
# <!--end-->

# <--Mars bot -->
# Ve script
Marsbot:
START_DRAW:
	jal GO

READ_SCRIPT: 					# Doc script
	addi $t0, $zero, 0 			# luu gia tri rotate
	addi $t1, $zero, 0 			# luu gia tri time
	
 	READ_ROTATE:				# doc goc di chuyen
 		add $t7, $a1, $t6 		# dich bit cua script
		lb $t5, 0($t7)  		# doc cac ki tu cua script
		beq $t5, 0, END 		# ket thuc doc script
 		beq $t5, 44, READ_TIME 		# Kiem tra ki tu ',' -> Tiep tuc tim thoi gian ve
 		mul $t0, $t0, 10  
 		addi $t5, $t5, -48 		# So 0 co ma 48 trong bang ascii.
 		add $t0, $t0, $t5  		# chuyen gia tri string thanh integer
 		addi $t6, $t6, 1 		# tang bit len 1, doc
 		j READ_ROTATE 			# quay lai doc den khi gap dau ','
 	
 	READ_TIME: 				# doc thoi gian chuyen dong.
 		add $a0, $t0, $zero
		jal ROTATE			# ghi rotate vao HEADING
 		addi $t6, $t6, 1		# Bo qua dau ','
 		add $t7, $a1, $t6 		# ($a1 luu dia chi cua pscript)
		lb $t5, 0($t7) 
		beq $t5, 44, READ_TRACK		# Kiem tra ki tu ',' -> Tiep tuc thuc hien ve hoac khong ve
		mul $t1, $t1, 10
 		addi $t5, $t5, -48
 		add $t1, $t1, $t5
 		j READ_TIME 			# quay lai doc den khi gap dau ','
 	
 	READ_TRACK:				
 		addi $v0,$zero,32 		# Cho chuong trinh chay voi thoi gian ngu luu o $t1
 		add $a0, $zero, $t1		# $a0 = sleeping runtime
 		addi $t6, $t6, 1 		# Dich bit them 1, bo qua ','
 		add $t7, $a1, $t6
		lb $t5, 0($t7) 
 		addi $t5, $t5, -48		
 		beq $t5, $zero, CHECK_UNTRACK 	# Kiem tra chuong trinh ve hoac ko ve
 						# 1 = ve / 0 = khong ve
 		jal UNTRACK			# Ket thuc ve mot net
		jal TRACK			
		j INCREAMENT
	
CHECK_UNTRACK:
	jal UNTRACK
INCREAMENT:					# Net ve tiep theo
	syscall
 	addi $t6, $t6, 2 			# bo qua dau ';'
 	j READ_SCRIPT

GO: 						# Di chuyen Mars Bot
 	li $at, MOVING 
 	addi $k0, $zero,1 
 	sb $k0, 0($at) 
 	jr $ra

STOP: 						# Dung Mars Bot
	li $at, MOVING 
 	sb $zero, 0($at)
 	jr $ra

TRACK: 						# Khac vao bang
	li $at, LEAVETRACK 
 	addi $k0, $zero,1 
	sb $k0, 0($at) 
 	jr $ra

UNTRACK:					# Khong khac
	li $at, LEAVETRACK 
 	sb $zero, 0($at) 
 	jr $ra

ROTATE: 					# Set rotate
	li $at, HEADING 
 	sw $a0, 0($at) 
 	jr $ra
END:						# In thong bao khi ve xong script
	jal STOP
	li $v0, 55
	la $a0, error
	li $a1, 1
	syscall
	li $v0, 10
	syscall
# <!--end-->
