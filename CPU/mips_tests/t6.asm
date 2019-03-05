## TEST 6 ##

## Implementation in my CPU:
	# addi $7,$0,17
	# addi $11,$0,-3
	# bne $11,$7,B_GO
	# addi $1,$0,2
	# sll $0,$0,0
	# sll $0,$0,0
	# B_GO: addi $1,$0,1
	#sw $1,15($7)
	
.data
	var: .word 00

.text

	addi $7,$0,17
	addi $11,$0,-3
	bne $11,$7,B_GO
	addi $9,$0,2
	sll $0,$0,0
	sll $0,$0,0
	B_GO: addi $9,$0,1

	la $t0,var
	add $t0,$t0,$7
	
	sw $9,15($t0)
