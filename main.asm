.data
	prompt: .asciiz "Please input the nuber to subtract: "
	prompt_result: .asciiz "Xnor result: "
	id: .word 54940527
 
.text
	# $t0: user input
	# $t1: id
	# $t2: 10
	# $t3: user input length counter
	
	main:
		lw $t1, id				#load id from sys memory to $t1
		addi $t2, $zero, 10 #Set a integer 10
		
		#Prompt for user input
		li $v0, 4										#Service: print_string
		la $a0, prompt							#Load the message to $a0
		syscall
	
		#Get user input
		li $v0, 5										#Get user input integer
		syscall
		move $t0, $v0								#Save user input to $t0
			
		#Display result
		li $v0, 4										#Service: print_string
		la $a0, prompt_result				#Load the message to $a0
		syscall
		
		#Perform xor
		addi $t3, $zero, 1					#Reset length to 1
		while2:
			beq $t0, 0, exit2 				#while user input<0
			mult $t3, $t2							#length = length * 10
			mflo $t3									#length = length * 10
			
			div $t0, $t2							#devide input with 10
			mflo $t0									#(int) input = input / 10
			mfhi $t4									#set the reminder to $t4
			div $t1, $t2							#devide id with 10
			mflo $t1									#(int) id = id / 10
			mfhi $t5									#set the reminder to $t5
			
			beq $t4, $t5, printOne    #if the reminder is the same
			bne $t4, $t5, printZero		#if the remainder is not equal

		exit2:
			li $v0, 1	
			move $a0, $t3
			syscall
			#End of Program
			li $v0, 10
			syscall
	
	printOne:
			addi $t6, $zero, 1
			li $v0, 1									#Service: print_integer
			move $a0, $t6							#Load the message to $a0
			syscall
			j while2

	printZero:
			addi $t6, $zero, 0
			li $v0, 1									#Service: print_integer
			move $a0, $t6							#Load the message to $a0
			syscall
			j while2
