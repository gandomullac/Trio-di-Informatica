	.data 
arr_w: 	.word 55,91,6,32,13

	
	.text 
init:
	add $s0, $zero, $zero #i=0
	addi $s1, $zero, 5    #i=5
	
	la $a1, arr_w
	
	
	lw $t4, 0($a1) #max
	lw $t6, 0($a1) #min

	
L:
	slt $t2, $s0, $s1
	beq $t2, $zero, E
	
	sll $t2, $s0, 2
	add $t2, $t2, $a1
	

	lw $t3, 0($t2) #arr[i]
	
	
	slt $t5, $t4, $t3 #if max < arr[i] -->t5=1
	beq $t5, $zero, H #if t5=0 jump H
	la $t4,($t3)
	 

		
H:
	slt $t7, $t3, $t6 #if min < arr[i] -->t7=1
	beq $t7, $zero, G #if t7=0 jump G
	la $t6,($t3)

G:
	addi $s0, $s0, 1

	j L
	
E:
	#print
	addi $v0, $zero, 1
	la 	$a0, ($t4) #print max
syscall

	li $a0, 32 #print space
	li $v0, 11 
syscall
	
	li $v0, 1
	la 	$a0, ($t6) #print min
syscall
	#exit:
	addi $v0, $zero, 10
syscall
