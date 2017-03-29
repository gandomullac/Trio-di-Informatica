	.data 				# Seguono le direttive
even:	.asciiz "even number"		# Predispongo la stringa per un valore pari
odd:	.asciiz "odd number"		# Predispongo la stringa per un valore dispari

	.text 				# Seguono le linee di codice
load_params:

MAIN:
	li $a1, 12			# Dichiaro un valore n
	jal ODD_EVEN			# Chiamata di funzione
	or $s0, $v0, $zero		# Dichiarazione della variabile di salvataggio
	li $v0, 4			#!# # Predispongo la variabile della chiamata a sistema a 4 -> stampa stringa
	beq $s0, $zero, print_even	# Se il valore di ritorno dà 0, salta alla stampa della stringa
		
print_odd:
	la $a0, odd			# Carica l'indirizzo della stringa per il valore dispari
	syscall				# Stampo a video la stringa precedentemente caricata
	
	addi $v0, $zero, 10		# Predispongo la variabile della chiamata a sistema a 10 -> termina l'esecuzione
	syscall				# Termino l'esecuzione

print_even:
	la $a0, even			# Carico l'indirizzo della stringa per il valore pari
	syscall				# Stampo a video la stringa precedentemente caricata
	addi $v0, $zero, 10		# Predispongo la variabile della chiamata a sistema a 10 -> termina l'esecuzione
	syscall				# Termino l'esecuzione
	
ODD_EVEN:
	li $t0, 1			# Creo una variabile di valore 1
	and $t1, $t0, $a1		# Eseguo il bitwise AND fra la variabile n e 1
	add $v0, $t1, $zero		# Salvo la variabile di ritorno
	jr $ra				# Esco dalla funzione
	