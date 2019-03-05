## TEST 7 ##

## Implementation in my CPU:
	# lui $1,0x00001001
	# ori $13,$1,0x00000020
	# lui $1,0x00000123
	# ori $9,$1,0x00004567
	# sw $9,0($13)
	# lh $11,2($13)
	# sw $11,16($13)
	
.data
	var: .word 00

.text

	lui $10,0x00001001
	ori $13,$10,0x00000020
	lui $10,0x00000123
	ori $9,$10,0x00004567
	
	la $t0,var
	add $t0,$t0,$7
	
	sw $9,0($13)
	lh $11,2($13)
	sw $11,16($13)
