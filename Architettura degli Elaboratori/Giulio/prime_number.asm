	 .data  
prime:	 .asciiz "prime number"	
not_prime:.asciiz "not a prime number"	 

number:  .word 97

	.text 
MAIN:
	la $t0, number #carico in t0 l'indirizzo di number
	lw $a1, 0($t0) #carico in a1 number
	
	div $a2, $a1, 2 #divido number per 2 e carico il risultato in a2
	
	jal PRIME #salto a PRIME
	
	move $s0, $v0 #salvo il contenuto di v0 in s0
	li $v0, 4 #carico in v0 la procedura di stampa stringa
	
	beq $s0, $zero, end_not_prime #salta a label_end se t2 = 0
	
end_prime:
	la $a0, prime #carico la sringa in a0
syscall
	j exit #salto a exit
	
end_not_prime:
	la $a0, not_prime #carico la sringa in a0
syscall
	j exit #salto a exit
exit:
	addi $v0, $zero, 10 #carico in v0 la procedura d'uscita
syscall

PRIME:
	move $v0, $zero #setto esplicitamente t0 a 0

	li $t1, 2 #carico il divisore

loop:
	slt $t2, $t1, $a2 #set t2 a 1 se t1 < a1
	beq $t2, $zero, end_divisor_not_found #salta a label_end se t2 = 0
	
	div $a1, $t1 #divido number per il divisore
	mfhi $t3 #sposto il resto della divisione in t3
	
	beq $t3, $zero, end_divisor_found #salta a label_end se t2 = 0
	addi $t1, $t1, 1 #incremento il divisore
	
	j loop #salto all'inizo del ciclo
	
end_divisor_found: #not prime
	jr $ra #salto a main
	
end_divisor_not_found: #prime
	li $v0, 1 #carico 1 (prime=true) in v0
	jr $ra #salto a main
