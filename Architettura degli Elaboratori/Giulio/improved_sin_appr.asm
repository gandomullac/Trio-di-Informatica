	.data
	.include "improved_sintable.asm"

	.text
MAIN:
	
	
	jal SIN_APPR #salto alla funzione di approssimazione seno
	
	li $v0, 2 #carico in v0 la procedura di stampa floating point
	mov.s $f12, $f30 #sposto il valore contenuto in f30 nel registro f12 in cui va il floating point da stampare
syscall
	#exit:
	addi $v0, $zero, 10
syscall
	
SIN_APPR:
	lwc1 $f3, var #carico la variabile var (in questo caso la mia x) in f3 
	lwc1 $f4, x0 #carico la variabile x0 in f4
	lwc1 $f5, xstep #carico la variabile xstep in f5
	
	
	sub.s $f6, $f3, $f4 #ho eseguito la sottrazione a=x-x0
	div.s $f6, $f6, $f5 #ho eseguito la divisione b=a/x
	floor.w.s $f7, $f6 #effettuo l'arrotondamento index=floor(b) N.B. PRODUCE UN INTEGER DENTRO UN REGISTRO FP !!!!!!!!!!!!!
	mfc1 $t0, $f7 #sposto il valore float contenuto in f7 in un registro integer per poterlo usare nella moltiplicazione
	

#####################################
#	move $a0, $t0
	#li $v0, 1 
#syscall
#################################   debug printer
	
 	andi $t7, $t0, 2147483648 #bin = 1000 0000 0000 0000 0000 0000 0000 00000  --> estraggo il bit di segno
 	beq $t7, $zero, non_negative_input
	mul $t0, $t0, -1 #se l'input era negativo ne cambio il segno
	li $s2, 1 #se l'input era negativo, setto a 1 il registro s2....mi servira' dopo nello XOR
	
non_negative_input:

#####################################
	#move $a0, $t0
	#li $v0, 1 
#syscall
#################################   debug printer
			
				
									
	lw $t2, N #carico N in t2
	div $t0, $t2 # divido l'indice trovato dopo floor per il numero di elementi della lookup table (ogni passaggio
	# completo sulla lookup table equivale ad un angolo piatto coperto cioe' da 0 a pi)
	mflo $t5 # ottengo il quoziente della divisione eseguita
	
	li $t6, 1 #carico in t6 il bin 0000 0000 0000 0000 0000 0000 0000 0001
	and $s3, $t5, $t6 # estraggo l'ultimo bit del quoziente della divisione per verificare se tale quoziente e' pari (finirebbe
	# per 0 in binario,quadranti positivi) oppure dispari (finirebbe per 1 in binario, quadranti negativi)
	
	
	xor $s4, $s2, $s3 #input negativo e angolo nei quadranti negativi --> xor 1 1 = 0
			  #input negativo e angolo nei quadranti positivi --> xor 1 0 = 1
	                  #input positivo e angolo nei quadranti negativi --> xor 0 1 = 1
	                  #input positivo e angolo nei quadranti positivi --> xor 0 0 = 0
	                  
	beq $s4, $zero, lookup_table_select # se il risultato dello XOR e' 0, salto la procedura di stamoa del segno meno
	
	li $a0, 45 #carico in a0 il codice ascii per "meno"
	li $v0, 11 #carico in v0 la procedura di stampa carattere
syscall
	
	
lookup_table_select: #argument: table index   0<index<100
	mfhi $t4 # ottengo il resto della divisione eseguita

	mul $t1, $t4 ,4 #calcolo la posizione dell'elemento da estrarre da sintable effettuando la moltiplicazione index x dim(word)
	lwc1 $f30, sintable($t1) #carico in f8 il valore estratto da sintable di indirizzo offsettato del contenuto di t0
	
	
	jr $ra #torno al main
	


