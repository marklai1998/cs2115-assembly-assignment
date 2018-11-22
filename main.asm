.data
	mymsg: .asciiz "Hello, world! \n"
 
.text
	la $a0,mymsg
	li $v0,4
	syscall