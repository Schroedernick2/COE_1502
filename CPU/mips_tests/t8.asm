## TEST 8 ##

## Implementation in my CPU:
	# lui $1,0x00001001
	# ori $13,$1,0x00000020
	# addi $9,$0,-45
	# clo $10,$9
	# sw $10,0($13)
	
.data
	var: .word 00

.text

	lui $11,0x00001001
	ori $13,$11,0x00000020
	addi $9,$0,-45
	clo $10,$9
	
	la $t0,var
	add $t0,$t0,$13
	
	sw $10,0($13)
