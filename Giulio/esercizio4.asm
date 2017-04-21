	.data 
arr_w: 	.word 10,8,10,2,15
	
	.text 
init:
	add $t0, $zero, $zero #i=0
	addi $t1, $zero, 5    #i=5
	la $a1, arr_w
	addi $v0, $zero, 1
	
L:
	slt $t2, $t0, $t1
	beq $t2, $zero, E
	
	sll $t2, $t0, 2
	add $t2, $t2, $a1
	

	lw $t3, 0($t2)
	
	addi $t0, $t0, 1
	
	add $t4, $t4, $t3
	
	j L
E:
#print
	la 	$a0, ($t4)
syscall

	#exit:
	addi $v0, $zero, 10
syscall
