
	.text 
init:
	addi $t1, $zero, 30
	addi $t2, $zero, 20

compare:
	slt	$t4, $t1, $t2
	bne	$t4, $zero, n2_max
	
n1_max:
	add $t3, $t1, $zero
	j	exit

n2_max:
	add $t3, $t2, $zero


exit:
	addi $v0, $zero, 10
	syscall 
