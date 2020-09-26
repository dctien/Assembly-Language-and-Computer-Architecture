.data
prompt: .asciiz 
userInput: .space 20 

.globl main
.text
main:
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 8
    la $a0, userInput
    li $a1, 20
    syscall 

    add $t0, $a0, $0            
    Length: 
        lbu   $t2, 0($t0)
        beq   $t2, $zero, Exit  
        addiu $t0, $t0,   1     
        j Length
    Exit:
    add $t1, $t0, $0     
    li  $t2, 0          
    li $v0, 11
    stringreverse:
        slt  $t3, $t2, $t1    
        beq  $t3, $0,  Exit2  
        addi $t0, $t0, -1     
        lbu  $a0, 0($t0)      
        syscall
        j stringreverse
    Exit2:
    li $v0, 10
    syscall
