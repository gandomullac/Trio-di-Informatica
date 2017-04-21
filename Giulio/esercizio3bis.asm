	.data 
even:	.asciiz "even number"	
odd:	.asciiz "odd number"

	.text 
	
MAIN:
	li $a1, 12
jal ODD_EVEN

	or $s0, $v0, $zero
	
	addi $v0, $zero, 4 #stampa stringa
	
	beq $s0, $zero, print_even
	
	
print_odd:
	la $a0, odd
syscall
	#exit:
	addi $v0, $zero, 10
syscall 

print_even:
	la $a0, even
syscall
	#exit:
	addi $v0, $zero, 10
syscall 

	
ODD_EVEN:
	li $t0, 1 #crea una variabile di valore uno da usare nell' and
	
	and $t1, $t0, $a1
	add $v0, $t1, $zero
	jr $ra