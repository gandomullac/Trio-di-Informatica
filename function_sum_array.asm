.data 
Numbers: .word 1 2 3 4 5

.text

add $a0, $zero, $zero
ori $a1, $zero,5
or $a2, $zero, $zero 
jal FUN



addi $v0,$zero,1
 	la $a0,($a2)
 	syscall
 
 j exit


FUN:
la $t1, Numbers

for: 
	slt $t0,$a0,$a1
 	beq $t0,$zero, return
 
 	sll $t0,$a0, 2
 	add $t0,$t0,$a0
 	
 	lw $t0,($t1)
 
 	add $a2,$a2,$t0
 	
 	addi $t1, $t1, 4
 	
 	
 	
 	addi $a0,$a0, 1
 	j for

return: 
jr $ra


exit:
addi $v0,$zero,10
 	syscall
