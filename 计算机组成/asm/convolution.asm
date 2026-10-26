.data
A: .space 1024
B: .space 1024
C: .space 1024

.macro read_int(%reg)
	li $v0, 5
	syscall
	move %reg, $v0
.end_macro

.macro print_int(%reg)
	li $v0, 1
	move $a0, %reg
	syscall
.end_macro

.macro printsp()
	li $v0, 11
	li $a0, 32
	syscall
.end_macro

.macro println()
	li $v0, 11
	li $a0, 10
	syscall
.end_macro

.macro load_mat(%reg, %mat, %i, %j)
	sll $t7, %i, 4
	add $t7, $t7, %j
	sll $t7, $t7, 2
	lw %reg, %mat($t7)
.end_macro

.macro store_mat(%reg, %mat, %i, %j)
	sll $t7, %i, 4
	add $t7, $t7, %j
	sll $t7, $t7, 2
	sw %reg, %mat($t7)
.end_macro

.text
	read_int($s0) # s0: n1
	read_int($s1) # s1: m1
	read_int($s2) # s2: n2
	read_int($s3) # s3: m2

	# read matrix A
	li $t0, 0
L1:
		li $t1, 0
L2:
			li $v0, 5
			syscall
			store_mat($v0, A, $t0, $t1)
			addi $t1, $t1, 1
			blt $t1, $s1, L2
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
			blt $t1, $s3, L4
		addi $t0, $t0, 1
		blt $t0, $s2, L3

	sub $s4, $s0, $s2
	addi $s4, $s4, 1 # s4: n3
	sub $s5, $s1, $s3
	addi $s5, $s5, 1 # s5: m3
	
	# calculate convolution
	li $t0, 0
L5:
		li $t1, 0
L6:
			li $t2, 0
L7:
				li $t3, 0
L8:
					add $t4, $t0, $t2
					add $t5, $t1, $t3
					load_mat($t4, A, $t4, $t5)
					load_mat($t5, B, $t2, $t3)
					load_mat($t6, C, $t0, $t1)
					mulo $t4, $t4, $t5
					add $t6, $t6, $t4
					store_mat($t6, C, $t0, $t1)

					addi $t3, $t3, 1
					blt $t3, $s3, L8
				addi $t2, $t2, 1
				blt $t2, $s2, L7
			addi $t1, $t1, 1
			blt $t1, $s5, L6
		addi $t0, $t0, 1
		blt $t0, $s4, L5

	# print matrix
	li $t0, 0
L9:
		li $t1, 0
L10:
			load_mat($t2, C, $t0, $t1)
			print_int($t2)
			printsp()
			addi $t1, $t1, 1
			blt $t1, $s5, L10
		println()
		addi $t0, $t0, 1
		blt $t0, $s4, L9

	li $v0, 10
	syscall
