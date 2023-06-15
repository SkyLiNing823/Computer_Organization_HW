.data
msg1:	.asciiz "Enter first number: "
msg2:	.asciiz "Enter second number: "
msg3:	.asciiz "The GCD is: "

.text
.globl main

# a = $t0
# b = $t1
# result = $t2

#------------------------- main -----------------------------

main:
# print msg1 on the console interface
	li  $v0, 4			# call system call: print string
	la  $a0, msg1			# load address of string into $a0
	syscall                 	# run the syscall

# read the input integer in $v0
 	li $v0, 5          	# call system call: read integer
  	syscall                 # run the syscall
 	move $t0, $v0      	# store input in $t0 (set arugument of procedure factorial)

# print msg2 on the console interface
	li $v0, 4			# call system call: print string
	la  $a0, msg2			# load address of string into $a0
	syscall                 	# run the syscall

# read the input integer in $v1
 	li $v0, 5          	# call system call: read integer
  	syscall                 # run the syscall
  	move $t1, $v0      	# store input in $t1 (set arugument of procedure factorial)

# jump to procedure factorial
  	jal GCD
	move $t0, $v0		# save return value in t0 (because v0 will be used by system call) 

# print msg3 on the console interface
	li $v0, 4			# call system call: print string
	la $a0, msg3		# load address of string into $a0
	syscall                 	# run the syscall

# print the result of procedure factorial on the console interface
	move $a0, $t2			
	li  $v0, 1				# call system call: print integer
	syscall 				# run the syscall

   
	li $v0, 10					# call system call: exit
  	syscall						# run the syscall



#------------------------- procedure GCD -----------------------------

#  rem       rd        rs        rt        rd = rs MOD rt

GCD:	
	addi $sp, $sp, -4	
	sw $ra, 0($sp)
	rem $t3, $t0, $t1
	bne $t3, $zero, L1
	move $t2, $t1
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
L1:	
	move $t0, $t1
	move $t1, $t3
	jal GCD
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	

