	.data 
arr_w: 	.word 55,92,7,32,13

	
	.text 
MAIN:
	li $a1, 5 #carico in a1 la dimensione logica dell'array
	
	jal ARR_MAX_MIN #salto ad ARR_MAX_MIN
	
	move $s0, $v0 #salvo il contenuto di v0 in s0
	move $s1, $v1 #salvo il contenuto di v1 in s1
		
	li $v0, 1 #carico in v0 la procedura di stampa intero
	move $a0, $s0 #sposto il contenuto di s0 in a0
syscall

	li $a0, 32 #carico in a0 il codice ascii per "spazio"
	li $v0, 11 #carico in v0 la procedura di stampa carattere
syscall

	li $v0, 1 #carico in v0 la procedura di stampa intero
	move $a0, $s1 #sposto il contenuto di s0 in a0
syscall

	#exit:
	addi $v0, $zero, 10
syscall
	
	
ARR_MAX_MIN:
	la $t0, arr_w #carico in t0 l'indirizzo dell array
	lw $t4, 0($t0) #carico in t4 il primo elemento dell'array come temporaneo max
	lw $t6, 0($t0) #carico in t6 il primo elemento dell'array come temporaneo min
	li $t1, 0 #carico 0 come indice iniziale dell'array
	
	
label_1:
	slt $t2, $t1, $a1 #set t2 a 1 se t1 < a1
	beq $t2, $zero, label_end #salta a label_end se t2 = 0
	
	sll $t2, $t1, 2 #shift logico a sinistra: t2 = indice array * 4
	add $t2, $t2, $t0 #avanzo da t0 (indirizzo base array) i byte calcolati sopra e carico il nuovo indirizzo in t2
	

	lw $t3, 0($t2) #carico in t3 il valore dell'array prelevato all'indirizzo determinato da t2
	
	
	slt $t5, $t4, $t3 #set t5 a 1 se t4(max) < t3(elemento prelevato)
	beq $t5, $zero, label_3 #salta a label_3 se t5 = 0
	move $t4, $t3 #set come nuovo massimo(t4) l'elemento prelevato dall'array che era in t3

label_3:
	slt $t7, $t3, $t6 #set t7 a 1 se t3(elemento prelevato) <  t6(min)
	beq $t7, $zero, label_2 #salta a label_2 se t7 = 0
	move $t6, $t3 #set come nuovo minimo(t6) l'elemento prelevato dall'array che era in t3
	
label_2:
	addi $t1, $t1, 1 #incremento di 1 l'indice dell'array
	j label_1 #salto a label_l
	
label_end:
	move $v0, $t4 #sposto il massimo in v0
	move $v1, $t6 #sposto il minimo in v1
	jr $ra #ritorno a main





	
