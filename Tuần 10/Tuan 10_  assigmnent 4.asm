.eqv KEY_CODE 0xFFFF0004 # ASCII code from keyboard, 1 byte
.eqv KEY_READY 0xFFFF0000 # =1 if has a new keycode ?
# Auto clear after lw
.eqv DISPLAY_CODE 0xFFFF000C # ASCII code to show, 1 byte
.eqv DISPLAY_READY 0xFFFF0008 # =1 if the display has already to do
# Auto clear after sw
.data
	message: .asciiz "exit"
.text
	li $k0, KEY_CODE
	li $k1, KEY_READY
	li $s0, DISPLAY_CODE
	li $s1, DISPLAY_READY
	la $t5, message
	addi $t4,$zero,0

loop: nop
WaitForKey: 
	lw $t1, 0($k1) # $t1 = [$k1] = KEY_READY
	nop
	beq $t1, $zero, WaitForKey # if $t1 == 0 then Polling
	nop
#-----------------------------------------------------
ReadKey: 
	lw $t0, 0($k0) # $t0 = [$k0] = KEY_CODE
	nop
	lb $t6, 0($t5)
	addi $t5, $t5, 1
	beq $t0, $t6, target	
	subi $t5, $t5, 1
	addi $t4, $0, 0
	j WaitForDis				
target:
    add $t4, $t4, 1
    beq $t4, 4, end
#-----------------------------------------------------
WaitForDis: 
	lw $t2, 0($s1) # $t2 = [$s1] = DISPLAY_READY
	nop
	beq $t2, $zero, WaitForDis # if $t2 == 0 then Polling
	nop
#-----------------------------------------------------
Encrypt: addi $t0, $t0, 1 # change input key
#-----------------------------------------------------
ShowKey: 
	sw $t0, 0($s0) # show key
	nop
#-----------------------------------------------------
	j loop
	nop
end:
