	 .data
number:  .word 12

	.text 
MAIN:
	la $t0, number #carico in t0 l'indirizzo di number
	lw $a1, 0($t0) #carico in a1 number

	jal FACT_ITERATIVE # salto alla funzione fact_iterative
	
	move $a0, $v0 #salvo il contenuto di vo in a0
	li $v0, 1 #procedura stampa intero
syscall

exit:
	addi $v0, $zero, 10 #carico in v0 la procedura d'uscita
syscall
	
FACT_ITERATIVE:
	move $t0, $a1 #sposto il contenuto di a1 in t0
	move $v0, $a1 #sposto il contenuto di a1 in v0
loop:
	beq $t0, 1, end_label #se il contenuto di t0 diventa uguale a 1, esce
	
	addi $t0, $t0, -1 #decrementa t0
	
	mul $v0, $v0, $t0 #moltiplica 
	
	j loop #salta all'inizio del loop
	
end_label:
	jr $ra #ritorna al main
		