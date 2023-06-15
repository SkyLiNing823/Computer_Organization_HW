.data
msg1:	.asciiz "Enter the number n = "
msg2:	.asciiz " "
msg3:   .asciiz "*"
msg4:   .asciiz "\n"

.text
.globl main
# n = $t0
# temp = $t1
# i =$s0
# j =$s1
#------------------------- main -----------------------------
main:
		addi $sp, $sp, -8
		sw $s0, 0($sp)
		sw $s1, 4($sp)
		move $s0, $zero
# print msg1 on the console interface
		li      $v0, 4				# call system call: print string
		la      $a0, msg1			# load address of string into $a0
		syscall                 	# run the syscall
 
# read the input integer in $v0
 		li      $v0, 5          	# call system call: read integer
  		syscall                 	# run the syscall
  		
  		move    $t0, $v0      	
		move    $t1, $t0  
		addi 	$t1, $t1, 1
		srl	$t1, $t1, 1
		andi 	$t2, $t0, 1 
		bne	$t2,$zero, ELSE
		j LOOP1
	ELSE:	addi	$t1, $t1, -1
		j LOOP1
	LOOP1:	slt $a3, $s0, $t1
		beq $a3, $zero, EXIT1
		move $s1, $zero
		j LOOP2
		LOOP2:  slt $a3, $s0, $s1
			bne $a3, $zero, EXIT2
			li      $v0, 4
			la      $a0, msg2		
			syscall      
			addi $s1, $s1, 1   
			j LOOP2
		EXIT2:  move $s1, $zero
		       	sll $t2, $s0, 1
		       	sub $t2, $t0, $t2   	
		       	j LOOP3
		LOOP3: 	slt $a3, $s1, $t2
			beq $a3, $zero, EXIT3
			li      $v0, 4
			la      $a0, msg3		
			syscall      
			addi $s1, $s1, 1
			j LOOP3
		EXIT3:  li      $v0, 4
			la      $a0, msg4		
			syscall      
			addi $s0, $s0, 1
			j LOOP1 
	EXIT1:  addi $t2, $t0, 1
		srl $t2, $t2, 1
		addi $t2, $t2, -1
		move $s0, $t2
		j LOOP4
	LOOP4:  slt $a3, $s0, $zero
		bne $a3, $zero, EXIT4
		move $s1, $zero
		j LOOP5
		LOOP5:  slt $a3, $s0, $s1
			bne $a3, $zero, EXIT5
			li      $v0, 4
			la      $a0, msg2		
			syscall      
			addi $s1, $s1, 1   
			j LOOP5
		EXIT5: move $s1, $zero
		       	sll $t2, $s0, 1
		       	sub $t2, $t0, $t2
		       	j LOOP6
		LOOP6: slt $a3, $s1, $t2
			beq $a3, $zero, EXIT6
			li      $v0, 4
			la      $a0, msg3		
			syscall      
			addi $s1, $s1, 1
			j LOOP6
		EXIT6:  li      $v0, 4
			la      $a0, msg4		
			syscall      
			addi $s0, $s0, -1
			j LOOP4
	EXIT4:  	sw $s0, 0($sp)
		sw $s1, 4($sp)
		addi $sp, $sp, 8
		li $v0, 10					# call system call: exit
  		syscall	

