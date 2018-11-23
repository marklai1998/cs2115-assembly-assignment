.data
	prompt: .asciiz "Please input the nuber to subtract: "
	prompt_error: .asciiz "Input should be less than 8 digit!"
	prompt_result: .asciiz "Xnor result: "
	id: .word 54940527
 
.text
	# $t0: user input
	# $t1: id
	# $t2: 10
	# $t3: user input length counter
	# $t4: temp
	# $t5: temp
	# $t6: result
	
	main:
		lw $t1, id								 # Load id from sys memory to $t1
		addi $t2, $zero, 10						 # Set a integer 10
		
		# Prompt for user input
		li $v0, 4								# Service: print_string
		la $a0, prompt							# Load the message to $a0
		syscall
	
		# Get user input
		li $v0, 5								# Get user input integer
		syscall
		move $t0, $v0							# Save user input to $t0
		
		# Chect user input
		addi $t5, $zero, 99999999				# Set $t5 to 8 digit for checking
		bgt  $t0, $t5, error						# Display error message if it greater than 8 digit
		
		# Perform xor
		addi $t3, $zero, 1						# Reset length to 1
		while:
			beq $t0, 0, printResult 				# While user input<0

			div $t0, $t2						# Devide input with 10
			mflo $t0							# (int) input = input / 10
			mfhi $t4							# Set the reminder to $t4
			
			div $t1, $t2						# Devide id with 10
			mflo $t1							# (int) id = id / 10
			mfhi $t5							# Set the reminder to $t5
			
			beq $t4, $t5, addOne				# check if the 2 digit is equal

			mult $t3, $t2						# length = length * 10
			mflo $t3							# length = length * 10
			j while
		addOne:
			add $t6, $t6, $t3					# result = result + counter

			mult $t3, $t2						# length = length * 10
			mflo $t3							# length = length * 10
			j while							# Go back to the loop
			
	printResult:
		# Display result
		li $v0, 4								#Service: print_string
		la $a0, prompt_result						#Load the message to $a0
		syscall
		
		# Appen 0 if the length is too short
		addi $t4, $zero,0						# Set a 0 to print
		div $t3, $t2							# Devide length with 10
		mflo $t3								# (int) length = length / 10
		while2:
			ble  $t3, $t6, printValue 				# While user input<result
			
			# Print a 0
			li $v0, 1							# Service: print_integer
			move $a0,	$t4						# Load the message to $a0
			syscall
			div $t3, $t2						# Devide length with 10
			mflo $t3							# (int) length = length / 10
			j while2
		printValue:
			ble  $t6, $zero, exit 					# If the result is 0, dont need to display extra 0
			# Print the result value
			li $v0, 1							# Service: print_integer
			move $a0, $t6						# Load the message to $a0
			syscall
		exit:
			# End of Program
			li $v0, 10
			syscall

	error:
		# Display error
		li $v0, 4								# Service: print_string
		la $a0, prompt_error						# Load the message to $a0
		syscall
		# End of Program
		li $v0, 10
		syscall