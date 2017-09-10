	.data 
arr_w: 	.word 10,8,10,2,15
	
	.text 
	
MAIN:
	li $a1, 5 #dim logica array
	
	jal ARRAY_SUM
	
	or $s0, $v0, $zero
	
	li $v0, 1 #procedura stampa intero
	
	#print
	la 	$a0, ($s0)
syscall

	#exit:
	addi $v0, $zero, 10
syscall
	
ARRAY_SUM:
	la $t0, arr_w
	
	li $t1, 0
	
	L:
	slt $t2, $t1, $a1
	beq $t2, $zero, E #controllo di non essere alla fine dell'array
	
	sll $t2, $t1, 2
	add $t2, $t2, $t0
	

	lw $t3, 0($t2)
	
	addi $t1, $t1, 1 #aggiorno l'indice
	
	add $v0, $v0, $t3 #somma elemento ai precedentemente sommati
	
	j L
E:
	jr $ra