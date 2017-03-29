.data 
A: .word 13 6 14 0 11
minore: .asciiz "il numero minore e': "
maggiore: .asciiz "il numero maggiore e': " 
.text

li $a1,0
li $a2,5
la $a3, A 

jal FUN

addi $v0,$zero,10
 	
 	syscall


FUN:
add $t0,$zero,$zero #max
addi $t1,$zero,1000 #min

for: 
	slt $t2,$a1,$a2  #paragone
 	beq $t2,$zero, exit # for
 
 	sll $t2,$a1, 2
 	add $t2,$t2,$a1
 	
 	lw $t2,($a3) #carico 
 	

 	blt $t2,$t1, less
 	 returnless:

 	bgt $t2,$t0, more
 	
 returnmore:
 	
 	addi $a3, $a3, 4 # mi sposto
 	
 	
 	addi $a1,$a1, 1
 	j for
 	
 	
 less:   
la $t1,($t2)
j returnless

 more:
 la $t0,($t2)
j returnmore 

exit:
addi $v0,$zero,4
la $a0, minore
syscall 
addi $v0,$zero,1
la $a0, ($t1)
syscall 
addi $v0,$zero,4
la $a0, maggiore
syscall 
addi $v0,$zero,1
la $a0, ($t0)
syscall 
jr $ra

