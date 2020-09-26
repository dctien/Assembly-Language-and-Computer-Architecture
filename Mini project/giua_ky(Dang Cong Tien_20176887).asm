.data          
	array: .space 11    #luu tru mang co toi da 10 phan tu
	input: .space 2
	message: .asciiz "Please enter ASCII string:  "
	message2: .asciiz "Parsing:  "
	null: .asciiz ""
	space: .ascii " "
	newline: .asciiz "\n"
.text
main:
	la $a0, message      
	li $v0, 4               
	syscall                          
read:          
	la $s1, array       
loop:           
	jal getc        
	lb $t0, input    #t0=input       
	sb $t0, 0($s1)   #aray=input   
	lb $t1, newline     
	beq $t0, $t1,  done
	addi $s1, $s1, 1    
	j loop          
getc:          
	li $v0, 8       
	la $a0, input        
	li $a1, 2       #do dai xau= 1 byte input + 1byte null
	syscall         
	jr $ra          
done:         
	addi $s1, $s1, -1   #con tro tro toi phan tu cuoi cung cua array
	la $s0, array       
#	addi $s0, $s0, -1   #s0 la phan tu dau tien cua array
	add $s2, $zero, $zero   # s2=sum =0
	li $t0, 10      
	li $t3, 1
	lb $t1, 0($s1)      
	addi $t1, $t1, -48  
	add $s2, $s2, $t1  
	addi $s1, $s1, -1   	

lp:       
	mul $t3, $t3, $t0   #t3*=10
	beq $s1, $s0, FIN   #thoat chuong trinh
	lb $t1, ($s1)       
	addi $t1, $t1, -48  
	mul $t1, $t1, $t3   
	add $s2, $s2, $t1   
	addi $s1, $s1, -1  
	j lp          

FIN:
	la $a0, message2      
	li $v0, 4               
	syscall  
	li $v0, 1
	add $a0, $s2, $zero
	syscall 
	li $v0, 10   
	syscall

	
