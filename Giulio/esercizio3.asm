	.data 
even:	.asciiz "even number"	
odd:	.asciiz "odd number"

	.text 
	load_params:
	addi $v0, $zero, 4 #stampa stringa
init:
	addi $t1, $zero, 11
	addi $t2, $zero, 1
	
	and $t3, $t1, $t2
	
compare:
	beq	$t3, $zero, print_even
print_odd:
	la 	$a0, odd
syscall
	#exit:
	addi $v0, $zero, 10
syscall 

print_even:
	la 	$a0, even
syscall
	#exit:
	addi $v0, $zero, 10
syscall 


