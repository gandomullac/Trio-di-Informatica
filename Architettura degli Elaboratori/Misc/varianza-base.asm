#####################################################
#	CALCOLO DELLA VARIANZA  - VERSIONE BASE	    #
#						    #
#	Gruppo di:				    #
#		Giacomo Antonioli		    #
#		Claudio Gandini			    #
#		Giulio Simani			    #
#####################################################

.data

array:		.word 	0, 1, 2, 3		# Elementi dell'array
num: 		.word	4			# Dimensione dell'array
zero:		.float 	0.0			# Costante 0 

array1:		.word  0, 10, 20, 30
num1:		.word  4

print_media:	.asciiz "Il valore della media è: "
print_varianza:	.asciiz "Il valore della varianza è: "
newline:	.asciiz "\n"			# Newline

.text

MAIN:
	la $a0, array				# Carico l'indirizzo dell'array nel registro degli argomenti $a0
	lw $a1, num				# Carico la dimensione dell'array num nel registro degli argomenti $a1
	
	jal VARIANZA				# Chiamo la funzione VARIANZA
	
	mov.s $f20, $f0				# Salvo il valore della media nel registro apposito
	mov.s $f22, $f2				# Salvo il valore della varianza nel registro apposito	
	
	mov.s $f12, $f20			# Copio il valore della media nel registro degli argomenti
	mov.s $f14, $f22			# Copio il valore della varianza nel registro degli argomenti	
	
	jal PRINT				# Chiamata a funzione
	
########################################################################################################################################	
# Ripeto il test per un secondo array	
	la $a0, array1				# Carico l'indirizzo dell'array nel registro degli argomenti $a0
	lw $a1, num1				# Carico la dimensione dell'array num nel registro degli argomenti $a1
	
	jal VARIANZA				# Chiamo la funzione VARIANZA
	
	mov.s $f20, $f0				# Salvo il valore della media nel registro apposito
	mov.s $f22, $f2				# Salvo il valore della varianza nel registro apposito	
	
	mov.s $f12, $f20			# Copio il valore della media nel registro degli argomenti
	mov.s $f14, $f22			# Copio il valore della varianza nel registro degli argomenti	
	
	jal PRINT				# Chiamata a funzione
	
		
	li $v0, 10				# Predispongo la chiamata a sistema -> Termina esecuzione
	syscall					# Chiamata a sistema
		
###     Termine esecuzione     ###


VARIANZA:

	addi $sp, $sp, -4			# Mi riservo una word di spazio nello stack
	sw $ra, 0($sp)				# Salvo l'indirizzo di ritorno al MAIN nello stack
	
	jal MEDIA				# Chiamata alla funzione MEDIA
	
	lw $ra, 0($sp)				# Ripristino l'indirizzo di ritorno al MAIN in $ra
	addi $sp, $sp, 4			# Libero lo spazio precedentemente riservato nello stack

	move $t0, $a0				# Copio l'indirizzo dell'array dal registro degli argomenti al registro temporaneo
	move $t1, $a1				# Copio la dimensione dell'array num dal registro degli argomenti al registro temporaneo
	sll $t2, $t1, 2				# Ottengo il numero di bytes occupati dall'array
	add $t3, $t0, $t2			# Ottengo il puntatore alla fine dell'array
        l.s $f5, zero				# inizializzo esplicitamente l'accumulatore $f5 a 0
        
varianza_for:	
	beq $t0,$t3, varianza_end_for		# Condizione di uscita dal ciclo
	lwc1 $f4, 0($t0)			# Estraggo, di volta in volta, un elemento dell'array in $f4 
	cvt.s.w $f4, $f4			# Converto il valore estratto da intero a floating point in singola precisione
	sub.s $f4, $f4, $f0			# Sottraggo al valore estratto dall'array la media calcolata in precedenza ###
	mul.s $f4, $f4, $f4			# Elevo al quadrato la sottrazione calcolata nell'istruzione precedente
	add.s $f5, $f5, $f4			# Accumulo, di volta in volta, i quadrati delle differenze in $f5
	addi $t0, $t0, 4			# Incremento della dimensione di una word il puntatore all'inizio dell'array per puntare all'elemento successivo
	j varianza_for				# Salto incondizionato per iterare il ciclo
	
varianza_end_for:
	mtc1 $t1, $f6				# Copio bit a bit num in un registro float
	cvt.s.w $f6, $f6			# Converto num da intero a floating point in singola precisione
	
	div.s $f2, $f5, $f6			# Ottengo la varianza dividendo l'accumulatore per num, salvando il risultato nel registro di ritorno float $f2
	jr $ra					# Ritorno al MAIN

MEDIA:
				
	move $t0, $a0				# Copio l'indirizzo dell'array dal registro degli argomenti al registro temporaneo
	move $t1, $a1				# Copio la dimensione dell'array num dal registro degli argomenti al registro temporaneo
	sll $t2, $t1, 2				# Ottengo il numero di bytes occupati dall'array in $t2
	add $t3, $t0, $t2			# Ottengo il puntatore alla fine dell'array in $t3
	add $t5, $zero, $zero			# Inizializzo esplicitamente l'accomulatore $t5 a 0

media_for:
	beq $t0,$t3, media_end_for		# Condizione di uscita dal ciclo
	lw $t4, 0($t0)				# Estraggo, di volta in volta, un elemento dell'array in $t4 
	add $t5, $t5, $t4			# Accumulo, di volta in volta, i singoli valori dell'array estratti in $t5
	addi $t0, $t0, 4			# Incremento della dimensione di una word il puntatore all'inizio dell'array per puntare all'elemento successivo
	j media_for				# Salto incondizionato per iterare il ciclo

media_end_for:
	mtc1 $t5, $f4				# Copio bit a bit il valore dell'accumulatore in un registro float
	cvt.s.w $f4, $f4			# Converto l'accumulatore da intero a floating point in singola precisione
	mtc1 $t1, $f5				# Copio bit a bit num in un registro float
	cvt.s.w $f5, $f5			# Converto num da intero a floating point in singola precisione
	
	div.s $f0, $f4, $f5			# Ottengo la media dividendo l'accumulatore per num, salvando il risultato nel registro di ritorno float $f0
	jr $ra					# Ritorno alla funzione chiamante
	
PRINT:
	li $v0, 4				# Predispongo la chiamata a sistema -> stampa stringa
	la $a0, print_media			# Carico l'indirizzo della stringa newline nel registro degli argomenti
	syscall 				# Chiamata a sistema

	li $v0, 2				# Predispongo la chiamata a sistema -> stampa floating point
	# Il valore della media si trova già nel registro $f12
	syscall 				# Chiamata a sistema
	
	li $v0, 4				# Predispongo la chiamata a sistema -> stampa stringa
	la $a0, newline				# Carico l'indirizzo della stringa newline nel registro degli argomenti
	syscall 				# Chiamata a sistema
	
	la $a0, print_varianza			# Carico l'indirizzo della stringa newline nel registro degli argomenti
	syscall 				# Chiamata a sistema
	
	li $v0, 2				# Predispongo la chiamata a sistema -> stampa floating point	
	mov.s $f12, $f14			# Copio il valore della varianza nel registro degli argomenti per la stampa
	syscall 				# Chiamata a sistema
	
	li $v0, 4				# Predispongo la chiamata a sistema -> stampa stringa
	la $a0, newline				# Carico l'indirizzo della stringa newline nel registro degli argomenti
	syscall 				# Chiamata a sistema

	jr $ra					# Ritorno al MAIN
	
	
	
	
	
	
	
