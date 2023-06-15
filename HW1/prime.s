.data
msg1:	.asciiz "Enter the number n = "
msg2:	.asciiz " is a prime "
msg3:	.asciiz " is not a prime, the nearest prime is"
msg4:	.asciiz " "

.text
.globl main

# n = $t0
# flag = $t1
# result = $t2

#------------------------- main -----------------------------

main:
	move $t0, $zero
	move $t1, $zero
# print msg1 on the console interface
	li  $v0, 4			# call system call: print string
	la  $a0, msg1			# load address of string into $a0
	syscall                 	# run the syscall

# read the input integer in $v0
 	li $v0, 5          		# call system call: read integer
  	syscall                 	# run the syscall
  	move $t0, $v0      		# store input in $t0 (set arugument of procedure factorial)

	jal prime
	beq $t2, $zero, mainELSE
	
	# print the result of procedure factorial on the console interface
	move $a0, $t0			
	li  $v0, 1				# call system call: print integer
	syscall 

	li $v0, 4			# call system call: print string
	la $a0, msg2		# load address of string into $a0
	syscall                 	# run the syscall
	
	j END
				
mainELSE:
	move $a0, $t0			
	li  $v0, 1				# call system call: print integer
	syscall 

	li $v0, 4			# call system call: print string
	la $a0, msg3		# load address of string into $a0
	syscall                 	# run the syscall
	
	addi $t8, $zero, 1
	move $t9, $t0
	j mainL1
mainL1:
	sub $t0, $t9, $t8
	jal prime
	beq $t2, $zero, mainELSE1
	li $v0, 4	
	la $a0, msg4	
	syscall  
	move $a0, $t0			
	li  $v0, 1		
	syscall 
	addi $t1, $zero, 1
	j mainELSE1
mainELSE1:
	add $t0, $t9, $t8
	jal prime
	beq $t2, $zero, mainELSE2
	li $v0, 4	
	la $a0, msg4	
	syscall  
	move $a0, $t0			
	li  $v0, 1		
	syscall 
	addi $t1, $zero, 1
	j mainELSE2
mainELSE2:
	bne $t1, $zero, END
	addi $t8, $t8, 1
	j mainL1

END:
	li $v0, 10			# call system call: exit
  	syscall				# run the syscall



#------------------------- procedure prime -----------------------------

#  rem       rd        rs        rt        rd = rs MOD rt
# i = v0
prime:	
	addi $sp, $sp, -4	
	sw $ra, 0($sp)
	addi $t3, $zero, 1
	bne $t0, $t3, ELSE
	add $t2, $zero, $zero	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
ELSE:
	addi $v0, $zero, 2
	j L1
L1:
	mul $t3, $v0, $v0
	slt $t4, $t0, $t3
	bne $t4, $zero, EXIT1
	rem $t5, $t0, $v0
	bne $t5, $zero, CONTINUE
	add $t2, $zero, $zero	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
CONTINUE:
	addi $v0, $v0, 1
	j L1
EXIT1:
	addi $t2, $zero, 1
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
	

