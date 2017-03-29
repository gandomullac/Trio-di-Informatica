	.text 				# Seguono le linee di codice
MAIN:	
	li $a0, 30			# Dichiaro a0
	li $a1, 20			# Dichiaro a1
	jal NMAX			# Chiamata a funzione
	or $s0,	$v0, $zero		# Salvo
	
	li $v0, 10			# Predispongo la variabile della chiamata a sistema a 10 -> termina l'esecuzione
	syscall				# Termino l'esecuzione
	
NMAX:
	slt $t0, $a0, $a1		# Confronto i due argomenti
	bne $t0, $zero, n2_max		# Se il confronto è uguale a 0, salto all'etichetta n2_max

n1_max:
	add $v0, $a0, $zero		# Imposto come valore di ritorno il primo valore
	jr $ra				# Esco dalla funzione con il primo valore
n2_max:
	add $v0, $a1, $zero		# Imposto come valore di ritorno il secondo valore
	jr $ra				# Esco dalla funzione con il secondo valore