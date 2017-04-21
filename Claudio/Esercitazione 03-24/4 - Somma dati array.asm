	.data 				# Seguono le direttive
arr_w: 	.word 10,8,10,2,15		# Scrivo i valori della direttiva word, che verranno poi inseriti nell'array
	
	.text 				# Seguono le linee di codice del programma
init:
	add $t0, $zero, $zero 		# Indice: 		i   = 0
	addi $t1, $zero, 5    		# Dimensione Logica:	DIM = 5
	la $a1, arr_w			# Ottengo l'indirizzo della word
	addi $v0, $zero, 1		# Predispongo la variabile della chiamata a sistema a 1 -> stampa intero
	
L:
	slt $t2, $t0, $t1		# Verifico che l'indice sia minore della dimensione logica
	beq $t2, $zero, E		# Nel caso i >= DIM, esco dal ciclo
	
	sll $t2, $t0, 2			# Shifto a sinistra l'indice per selezionare l'elemento successivo (indirizzo i-esimo elemento = indirizzo elemento 0 + (i • 4) )
	add $t2, $t2, $a1		# Sommo all'i-esimo elemento l'indirizzo della word, così da ottenere l'indirizzo della cella desiderata

	lw $t3, 0($t2)			# Leggo l'i-esimo elemento della word
	add $t4, $t4, $t3		# Sommo l'i-esimo dato dell'array in una variabile inizialmente vuota
	addi $t0, $t0, 1		# Aggiungo 1 all'indice		i++
	j L				# Ricomincio il ciclo
E:

print:
	la $a0, ($t4)			# Carico la somma dei dati dell'array
	syscall				# Stampo a video la variabile caricata ($v0 == 1)

exit:
	addi $v0, $zero, 10		# Predispongo la variabile della chiamata a sistema a 10 -> Termina l'esecuzione
	syscall				# Termino l'esecuzione
