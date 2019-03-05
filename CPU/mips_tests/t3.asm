## TEST 3 ##

## Implementation in my CPU:
	# addi $7,$0,17
	# addi $11,$0,-3
	# sra $11,$7,1
	# sw $11,15($7)
	
.data
	var: .word 00

.text

	addi $7,$0,17
	addi $11,$0,-3
	sra $11,$7,1

	la $t0,var
	add $t0,$t0,$7
	
	sw $11,15($t0)