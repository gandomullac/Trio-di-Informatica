	.data
insert:	.asciiz "seed?"	

	.text
MAIN:

	addi $v0, $zero, 4 #stampa stringa
print_instert:
	la $a0, insert
syscall


	#chiamata a tastiera per intero salvato in v0 (sovrascrive v0)
	li $v0, 5 
syscall

	move $a1, $v0 #sposto l'intero in a1

	
	li $a0, 1 #set id random gen
	
	li $v0, 40 #chiata set seed, set id in a0 e seed in a1
syscall



	li $v0, 42 #chiamata generatore di id a0 con limite numero in a1. carica numero generato in a0 sovrascrivendolo
	li $a1, 6 #limite strettamente superiore (numeri fino a sei escluso....ma dopo devo sommare 1)
syscall	
	addi $a0, $a0, 1 #sommo 1 per evitare che venga 0 (i dadi non hanno 0)


	#chiamata di stampa intero
	li $v0, 1 
syscall

	#exit:
	addi $v0, $zero, 10
syscall