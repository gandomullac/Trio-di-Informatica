	.data 
hello:	.asciiz "hello world"

	.text 
load_params:
	addi $v0, $zero, 4
	la 	$a0, hello
	
call_os:
	syscall 
exit:
	addi $v0, $zero, 10
	syscall 