	.data
.include "sintable.asm"
error:	.asciiz "lookup table field exceeded"
	.text
MAIN:
	
	
	jal SIN_APPR #salto alla funzione di approssimazione seno
	
	li $v0, 2 #carico in v0 la procedura di stampa intero
	mov.s $f12, $f30 #sposto il valore contenuto in f30 nel registro f12 in cui va il floating point da stampare
syscall
	#exit:
	addi $v0, $zero, 10
syscall
	
SIN_APPR:
	lwc1 $f3, pi #carico la variabile pi (in questo caso la mia x) in f3 (f0, f1, e f2 sono utilizzati per gli argomenti)
	lwc1 $f4, x0 #carico la variabile x0 in f4
	lwc1 $f5, xstep #carico la variabile xstep in f5
	
	sub.s $f6, $f3, $f4 #ho eseguito la sottrazione a=x-x0
	
	div.s $f6, $f6, $f5 #ho eseguito la divisione b=a/x
	
	floor.w.s $f7, $f6 #effettuo l'arrotondamento index=floor(b)
	
	mfc1 $t0, $f7 #sposto il valore float contenuto in f7 in un registro integer per poterlo usare nella moltiplicazione
	
	#controllo che la x non ecceda il limite della tavola di lookup
	lw $t2, N #carico N in t2
	slt $t1, $t0, $t2 #set t1 a 1 se t0 < t2
	beq $t1, $zero, exit_error #salta a label_end se t2 = 0
	
	mul $t1, $t0 ,4 #calcolo la posizione dell'elemento da estrarre da sintable effettuando la moltiplicazione index x dim(word)
	lwc1 $f30, sintable($t1) #carico in f8 il valore estratto da sintable di indirizzo offsettato del contenuto di t0
	#nota: si e' stabilito di salvare i valori di ritorno nei registri f30 e f31
	
	jr $ra #torno al main
	
exit_error: #procedura uscita con errore
	la $a0, error
	addi $v0, $zero, 4
	syscall
#exit:
	addi $v0, $zero, 10
syscall