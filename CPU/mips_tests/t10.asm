## TEST 10 ##

## Implementation in my CPU:
	# addi $11,$0,-3
	# bltzal $11,B_GO
	# sll $0,$0,0
	# j EXIT
	# sll $0,$0,0
	# B_GO: jr $31
	# sll $0,$0,0
	# EXIT sw $31, 32($zero)
	
.data
	var: .word 00

.text

	addi $11,$0,-3
	bltzal $11,B_GO
	sll $0,$0,0
	j EXIT
	sll $0,$0,0
	B_GO: jr $31
	sll $0,$0,0
	EXIT: sw $31, 32($zero)
