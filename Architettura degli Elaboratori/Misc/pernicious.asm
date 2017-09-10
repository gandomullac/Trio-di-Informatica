	.data				# Seguono le direttive
	
intro: 			.asciiz 	"Il numero "
pernicious:		.asciiz 	" e' pernicioso"
not_pernicious: 	.asciiz 	" non e' pernicioso"		
number:	.word	16

	.text				# Seguono le linee di codice

MAIN:
	lw $s0, number			# Carico il valore della word contenente il numero
	add $a0, $s0, $zero		# Copio il valore number nel registro per gli argomenti
	
	jal IS_PERNICIOUS		# Chiamata a funzione
	
	move $s1, $v0			# Salvo il valore di ritorno in $s1
	
	li $v0, 4			# Predispongo la chiamata al sistema ( 4 -> stampa stringa)
	la $a0, intro			# Carico l'indirizzo della stringa 
	syscall				# Chiamata a sistema
	
	li $v0, 1			# Predispongo la chiamata al sistema ( 1 -> stampa intero)
	move $a0, $s0			# Carico il valore del numero di partenza nel registro degli argomenti
	syscall				# Chiamata a sistema
	
	beqz $s1, print_not_pernicious	# Ai fini del della stampa, verifico che il valore salvato sia pernicioso o meno
	
	li $v0, 4			# Predispongo la chiamata al sistema ( 4 -> stampa stringa)
	la $a0, pernicious		# Carico l'indirizzo della stringa 
	syscall				# Chiamata a sistema
	
	j exit				# Salto incondizionato alla fine del MAIN
	 
print_not_pernicious: 
	
	li $v0, 4			# Predispongo la chiamata al sistema ( 4 -> stampa stringa)
	la $a0, not_pernicious		# Carico l'indirizzo della stringa
	syscall				# Chiamata a sistema

exit:
	li $v0, 10			# Carico la procedura di uscita in $v0
	syscall				# Chiamata a sistema
	# TERMINE DELL'ESECUZIONE
	
IS_PERNICIOUS:
	add $t0, $zero, $zero		# Inizializzo il contatore $t0
	add $t1, $zero, $a0		# Copio il valore number nel registro temporaneo $t1
	add $t5, $zero, $zero		# Inizializzo a 0 l'accumulatore sum in $t5

while:
	beq $t1, $zero, while_end	# Condizione di uscita ##
	div $t3, $t1, 2			# Nel registro $t3 salvo il quoziente per difetto
	move $t1,$t3  			# Sposto il quoziente al posto di number, per procedere con la divisione successiva
	mfhi $t4			# Salvo il resto della divisione
	add $t5, $t5, $t4		# Incremento l'accumulatore sum del resto della divisione
	j while				# Rieseguo il ciclo
	
while_end:	
	move $a0, $t5			# Sposto l'accumulatore sum nel registro degli argomenti
	addi $sp, $sp, -4		# Libero 4 byte per una word
	sw $ra, 0($sp)			# Carico in stack l'indirizzo di ritorno
		
	jal IS_PRIME			# Chiamata a funzione
	
	lw $ra,0($sp)			# Prelevo dallo stack l'indirizzo di ritorno al MAIN
	addi $sp, $sp, 4		# Dealloco lo spazio dallo stack
	jr $ra				# Ritorno al MAIN
	


IS_PRIME:
	move $t0, $a0			# Sposto il valore del registro degli argomenti $a0 contenente sum in $t0
	div $t1,$t0,2			# Ottimizzo il ciclo verificando i divisore di sum/2 anziche di sum
	blt $t0, 2, return_0
	addi $t2, $zero, 2		# Inizializzo l'indice i a 2
	
for:
	blt  $t1, $t2, return_1
	
	div $t0, $t2 			# Divido sum per l'indice per ottenere il resto nel registro HI
	mfhi $t3			# Salvo il resto della divisione in $t3
	beqz $t3, return_0
	addi $t2, $t2, 1		# Incremento il contatore i
	j for
	
	
	
	
return_0:
	add $v0, $zero, $zero		# Assegno 0 al registro di ritorno $v0
	jr $ra				# Ritorno alla funzione chiamante
	
return_1:
	addi $v0, $zero, 1		# Assegno 1 al registro di ritorno $v0
	jr $ra				# Ritorno alla funzione chiamante
