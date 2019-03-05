## TEST 9 ##

## Implementation in my CPU:
	# lui $1,0x00001001
	# li $3,0xFF0F
	# sw $3,32($1)
	# li $5, 0xBBBB
	# sll $0,$0,0
	# lw $2,32($1)
	# and $4, $2, $5
	# sw $4, 36($1)
	
.data
	var: .word 00

.text

	lui $1,0x00001001
	li $3,0xFF0F
		
	sw $3,32($1)
	li $5, 0xBBBB
	sll $0,$0,0
	lw $2,32($1)
	and $4, $2, $5

	sw $4, 36($1)
