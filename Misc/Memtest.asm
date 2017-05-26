#Giacomo Antonioli
#Claudio Gandini
#Giulio Simani
		
		
		.data
A:.word 0x10040000
B: .word  0x10050000

		.text
		
MAIN:

     # li $v0, 40
     # syscall

	
	lw $s0, A						# Salvo l'indirizzo di memoria A 
	move $a0, $s0						# Copio l'indirizzo di memoria A nel registro degli argomenti
	lw $s1, B						# Salvo l'indirizzo di memoria B
	move $a1, $s1						# Copio l'indirizzo di memoria B nel registro degli argomenti
		
	jal SET_ZERO						# Chiamata a funzione
	
	jal BYTE_INDEXER					# Chiamata a funzione
	
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0, 10						# Predispongo la chiamata a sistema -> Termine esecuzione
	syscall							# Chiamata a sistema
	
	###   TERMINE ESECUZIONE   ###


SET_ZERO:
	li $t1, 0
	move $t0, $a0
set_zero_for:
	
	beq $t0, $a1,set_zero_endfor				# Condizione di uscita
	sw $t1, 0($t0)						# Azzero la word, azzerando quindi ogni byte al suo interno
	addi $t0, $t0, 4					# Incremento l'indirizzo di memoria
	j set_zero_for						# Salto incondizionato

set_zero_endfor:
	jr $ra							# Ritorno al MAIN











BYTE_INDEXER:
	addi $sp, $sp, -16					# Libero 4 word di spazio
	sw $ra, 0($sp)						# Salvo nello stack l'indirizzo di ritorno
	

		
BYTE_INDEXER_for:
	sw $a0, 4($sp)						# Salvo nello stack l'indirizzo A	#################
	sw $a1, 8($sp)						# Salvo nello stack l'indirizzo B	##################

	move $t0, $a0
	move $t1, $a1
	beq $t0, $t1,BYTE_INDEXER_endfor			# Condizione di uscita
 	
 	jal READ_ADDR
 	
 	move $t0, $v1

add $t1, $zero, $zero
addi $t2, $zero, 2
lw $t4, 12($sp)
	
inner_for:

beq $t1, 4, end_inner_for

div $t0, $t2
mfhi $t3

beqz $t3, shift

addi $t4, $t4, 1


shift:
 
srl $t0, $t0, 8
addi $t1, $t1, 1

j inner_for

end_inner_for:
 
 	sw $t4, 12($sp)
 	
 	move $t0, $v0
	lw $t1, 8($sp)
 	
 	
	addi $t0, $t0, 4
	
	move $a0,$t0
	move $a1,$t1

	j BYTE_INDEXER_for					# Salto incondizionato
	
	

BYTE_INDEXER_endfor:








	lw $ra, 0($sp)

	lw $v0, 12($sp)
	###############
	addi $sp,$sp ,16
	################
	
	jr $ra

	
	
	

	
	
READ_ADDR:
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	move $t0, $a0
	
	
	jal INJECT_FAULT
	


	
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	
	
	lw  $v1,($v0)
	
	jr $ra
	
	
	
	
	
	
	




INJECT_FAULT:

	move $t0, $a0
	add $t1, $zero, $zero						# inizializzo a zero
	lw $t2, ($t0)

li $t3, 255
li $t5, 0								# inizializzo a zero
beqz $t2, put_one

put_zero:




	beq $t1, 4, INJ_endfor
		
			
					
	li $a1,50
	li $v0, 42
	syscall
	
	beqz $a0, error_gen_zero


j end_error_gen_zero

error_gen_zero:

not $t3,$t3

xor $t4,$t2, $t3

not $t3, $t3
or $t5, $t4, $t5
end_error_gen_zero:


	sll $t3, $t3, 8

	addi $t1, $t1, 1




	 
j put_zero	


put_one:


	beq $t1, 4, INJ_endfor
		
			
					
	li $a1,50
	li $v0, 42
	syscall
	
	beqz $a0, error_gen_one 
	

j end_error_gen_one

error_gen_one:

xor $t4, $t2, $t3
or $t5, $t4, $t5

end_error_gen_one:

	sll $t3, $t3, 8

	addi $t1, $t1, 1


j put_one



INJ_endfor:

sw $t5, ($t0)

move $v0,$t0
jr $ra

