	.text
MAIN:
	li $a0, 30
	li $a1, 20
jal NMAX
	or $s0, $v0, $zero

	li $v0,10 #exit procedure
	syscall


NMAX:
	slt $t0, $a0, $a1
	bne $t0, $zero, n2_max
	
n1_max:
	add $v0, $a0, $zero
	jr $ra
	
n2_max:
	add $v0, $a1, $zero
	jr $ra
