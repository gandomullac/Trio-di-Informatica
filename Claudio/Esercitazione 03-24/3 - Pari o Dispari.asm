	.data 				# Seguono le direttive
even:	.asciiz "even number"		# Predispongo la stringa per un valore pari
odd:	.asciiz "odd number"		# Predispongo la stringa per un valore dispari

	.text 				# Seguono le linee di codice
load_params:
	addi $v0, $zero, 4		# Predispongo la variabile della chiamata a sistema a 4 -> stampa stringa
init:
	addi $t1, $zero, 11		# Dichiaro un valore n
	addi $t2, $zero, 1		# Creo una variabile di valore 1
	
	and $t3, $t1, $t2		# Eseguo il bitwise AND fra la variabile n e 1		(es: 00010110 AND 00000001 -> 00000000 -> non è dispari)
	
compare:
	beq $t3, $zero, print_even	# Se l'operazione precedente dà 0, salta alla stampa della stringa
print_odd:
	la $a0, odd			# Carica l'indirizzo della stringa per il valore dispari
	syscall				# Stampo a video la stringa precedentemente caricata
exit_odd:
	addi $v0, $zero, 10		# Predispongo la variabile della chiamata a sistema a 10 -> termina l'esecuzione
	syscall				# Termino l'esecuzione

print_even:
	la $a0, even			# Carico l'indirizzo della stringa per il valore pari
	syscall				# Stampo a video la stringa precedentemente caricata
exit_even:
	addi $v0, $zero, 10		# Predispongo la variabile della chiamata a sistema a 10 -> termina l'esecuzione
	syscall				# Termino l'esecuzione