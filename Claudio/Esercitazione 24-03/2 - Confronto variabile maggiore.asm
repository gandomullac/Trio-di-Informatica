	.text 				# Seguono le linee di codice
init:
	addi $t1, $zero, 10		# Dichiaro la prima variabile
	addi $t2, $zero, 20		# Dichiaro la seconda variabile

compare:
	slt	$t4, $t1, $t2		# Se la prima variabile è minore della seconda, il registro t4 ottiene valore 1
	bne	$t4, $zero, n2_max	# Se il registro t4 è uguale a 0, salta all'etichetta n2_max
	
n1_max:					
	add $t3, $t1, $zero		# Aggiungo ad una terza variabile il valore maggiore, cioè la prima
	j	exit			# Salto all'etichetta exit

n2_max:
	add $t3, $t2, $zero		# Aggiungo ad una terza variabile il valore maggiore, cioè la seconda

exit:
	addi $v0, $zero, 10		# Predispongo la variabile della chiamata a sistema a 10 -> termina l'esecuzione
	syscall				# Termino l'esecuzione