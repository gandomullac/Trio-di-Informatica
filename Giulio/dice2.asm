	.data
insertseed:	.asciiz "seed?"	
insertn:	.asciiz "n lanci?"
	.text
MAIN:

	
	
print_instertn:
	li $v0, 4 #chiamata a tastiera per stampa stringa
	la $a0, insertn
syscall #lanci?	

	#chiamata a tastiera per intero salvato in v0 (sovrascrive v0)
	li $v0, 5 
syscall
	move $t8, $v0 #sposto l'intero in t8	N t8
	
	
print_instertseed:
	addi $v0, $zero, 4 #stampa stringa
	la $a0, insertseed
syscall #seed?
	#chiamata a tastiera per intero salvato in v0 (sovrascrive v0)
	li $v0, 5 
syscall
	move $t9, $v0 #sposto l'intero in t9	SEED t9
	

jal RANDOM_DICE


	move $a0, $s3
	#chiamata di stampa intero
	li $v0, 1 
syscall


	#exit:
	addi $v0, $zero, 10
syscall 


RANDOM_DICE:
	li $s3, 0 #setto esplicitamente il contatore s3 a 0
	li $s4, 0#setto esplicitamente il contatore s4 a 0

	move $a1, $t9
	li $v0, 40 #carico chiamata set seed con id in a0 e seed in a1
syscall

start:
	beq $s4, $t8, counter_end
	
	li $v0, 42 #chiamata generatore di id a0 con limite numero in a1. carica numero generato in a0 sovrascrivendolo
	li $a1, 6 #limite strettamente superiore (numeri fino a sei escluso....ma dopo devo sommare 1)
syscall	
	addi $a0, $a0, 1 #sommo 1 per evitare che venga 0 (i dadi non hanno 0)
	move $t1, $a0

syscall #lancio 2
	addi $a0, $a0, 1 #sommo 1 per evitare che venga 0 (i dadi non hanno 0)
	move $t2, $a0

syscall #lancio 3
	addi $a0, $a0, 1 #sommo 1 per evitare che venga 0 (i dadi non hanno 0)
	move $t3, $a0

bne $t1, $t2, different
bne $t2, $t3  different
addi $s3, $s3, 1 #s3 contatore risultato dadi uguale

different:
addi $s4, $s4, 1#contatore numero di lanci
j start
counter_end:
jr $ra
