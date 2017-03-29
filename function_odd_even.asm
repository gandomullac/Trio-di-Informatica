.data 

even: .asciiz "even number"
odd: .asciiz "odd number"


.text

load_params: 
ori $v0,$zero,4

ori $a1, $zero, 11
ori $a2, $zero, 1


jal FUN

addi $v0, $zero,10
syscall




FUN:
logic_and:

and $t0,$a1,$a2

compare:

beq $t0, $zero, print_even

print_odd:

la $a0,odd
syscall 
return_odd: 
jr $ra

print_even:

la $a0,even
syscall 

return_even: 
jr $ra
