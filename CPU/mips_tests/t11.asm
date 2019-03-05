## TEST 11 ##

.text
	addi $7,$0,17
	lui $17,0x2
	ori $17,0xC305
	lui $18,0x43A
	ori $18,0x4463
	
	multu $17,$18
	mfhi $8
	mflo $9
	sw $8,23($7)
	sw $9,27($7)