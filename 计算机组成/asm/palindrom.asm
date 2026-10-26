.data
str: .space 32

.text
	li $v0, 5
	syscall
	move $s0, $v0

	li $t0, 0
L1:
		li $v0, 12
		syscall
		sb $v0, str($t0)
		addi $t0, $t0, 1
	blt $t0, $s0, L1

	li $t0, 0
	subi $t1, $s0, 1
	li $s1, 1
L2:
		lb $t2, str($t0)
		lb $t3, str($t1)
		beq $t2, $t3, L3
		li $s1, 0
L3:
		addi $t0, $t0, 1
		subi $t1, $t1, 1
	ble $t0, $t1, L2

	li $v0, 1
	move $a0, $s1
	syscall
