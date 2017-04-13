.data
	testo1: .asciiz "Inserisci un numero: "
	testo2: .asciiz "Il fattoriale è:  "
.text
	la $a0,testo1
	jal fun_stampa_stringa
	jal fun_leggi_intero
	la $a3,($v0)			#CONTIENE IL NUMERO
	
	# pongo $s1=1 condizione di uscita ciclo
	addi $a1,$zero,1
	# inizializzo valore fattoriale
	addi $a2,$zero,1
	beq $a3,$a1,STAMPA
	
	jal fun_calcolo_fattoriale
	
	
STAMPA:	la $a0,testo2
	jal fun_stampa_stringa
	la $a0,($a2)
	jal fun_stampa_intero
EXIT:
	addi $v0,$zero,10
	syscall
	
	
# FUNZIONI

fun_calcolo_fattoriale:
	addi $sp,$sp,-4
	sw $ra,($sp)
	addi $sp,$sp,-4
	sw $a3,($sp)
	
	addi $a3,$a3,-1
	beq $a3,$a1,ESCI
	jal fun_calcolo_fattoriale

ESCI:	lw $t0,($sp)
	mult $a2,$t0
	mflo $a2
	addi $sp,$sp,4
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
	
	
	
	
	

fun_stampa_stringa:
	addi $v0,$zero,4
	syscall
	jr $ra
	
fun_leggi_intero:
	add $v0,$zero,5
	syscall
	jr $ra

fun_stampa_intero:
	add $v0,$zero,1
	syscall
	jr $ra
