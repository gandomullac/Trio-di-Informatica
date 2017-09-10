	.data 				# Seguono le direttive
arr_w: 	.word 10,8,10,2,15		# Scrivo i valori della direttiva word, che verranno poi inseriti nell'array
	
	.text 				# Seguono le linee di codice del programma
MAIN:
	li $a1, 5   	 		# Dimensione Logica:	DIM = 5
	jal ARRAY_SUM			# Chiamata di funzione
	or $s0, $v0, $zero		# Salvo
	li $v0, 1			# Predispongo la variabile della chiamata a sistema a 1 -> stampa intero
	
	la $a0, ($s0)			# Carico la somma dei dati dell'array
	syscall				# Stampo a video la variabile caricata ($v0 == 1)

	addi $v0, $zero, 10		# Predispongo la variabile della chiamata a sistema a 10 -> Termina l'esecuzione
	syscall				# Termino l'esecuzione
	
ARRAY_SUM:
	la $t0, arr_w			# Ottengo l'indirizzo della word
	li $t1, 0	 		# Indice: 		i   = 0
L:
	slt $t2, $t1, $a1		# Verifico che l'indice sia minore della dimensione logica
	beq $t2, $zero, E		# Nel caso i >= DIM, esco dal ciclo
	
	sll $t2, $t1, 2			# Shifto a sinistra l'indice per selezionare l'elemento successivo (indirizzo i-esimo elemento = indirizzo elemento 0 + (i • 4) )
	add $t2, $t2, $t0		# Sommo all'i-esimo elemento l'indirizzo della word, così da ottenere l'indirizzo della cella desiderata

	lw $t3, 0($t2)			# Leggo l'i-esimo elemento della word
	add $v0, $v0, $t3		# Sommo l'i-esimo dato dell'array in una variabile inizialmente vuota
	addi $t1, $t1, 1		# Aggiungo 1 all'indice		i++
	j L				# Ricomincio il ciclo
E:
	jr $ra				# Esco dalla funzione
