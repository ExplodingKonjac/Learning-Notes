.data
A: .space 256
B: .space 256
C: .space 256
sp: .asciiz " "
nl: .asciiz "\n"

.macro load_mat(%reg, %mat, %i, %j)
	sll $t7, %i, 3
	add $t7, $t7, %j
	sll $t7, $t7, 2
	lw %reg, %mat($t7)
.end_macro

.macro store_mat(%reg, %mat, %i, %j)
	sll $t7, %i, 3
	add $t7, $t7, %j
	sll $t7, $t7, 2
	sw %reg, %mat($t7)
.end_macro

.text
	li $v0, 5
	syscall
	move $s0, $v0 # s0: n

	# read matrix A
	li $t0, 0
L1:
		li $t1, 0
L2:
			li $v0, 5
			syscall
			store_mat($v0, A, $t0, $t1)
			addi $t1, $t1, 1
			blt $t1, $s0, L2
		addi $t0, $t0, 1
		blt $t0, $s0, L1

	# read matrix B
	li $t0, 0
L3:
		li $t1, 0
L4:
			li $v0, 5
			syscall
			store_mat($v0, B, $t0, $t1)
			addi $t1, $t1, 1
			blt $t1, $s0, L4
		addi $t0, $t0, 1
		blt $t0, $s0, L3
	
	# calcumate C = A * B
	li $t0, 0
L5:
		li $t1, 0
L6:
			li $t2, 0
L7:
				load_mat($t3, A, $t0, $t1)
				load_mat($t4, B, $t1, $t2)
				load_mat($t5, C, $t0, $t2)
				mulo $t3, $t3, $t4
				add $t5, $t5, $t3
				store_mat($t5, C, $t0, $t2)
				addi $t2, $t2, 1
				blt $t2, $s0, L7
			addi $t1, $t1, 1
			blt $t1, $s0, L6
		addi $t0, $t0, 1
		blt $t0, $s0, L5

	# print matrix C
	li $t0, 0
L8:
		li $t1, 0
L9:
			li $v0, 1
			load_mat($a0, C, $t0, $t1)
			syscall
			la $v0, 4
			la $a0, sp
			syscall
			addi $t1, $t1, 1
			blt $t1, $s0, L9
		la $v0, 4
		la $a0, nl
		syscall
		addi $t0, $t0, 1
		blt $t0, $s0, L8
