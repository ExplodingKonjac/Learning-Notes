.data
a: .space 4096

.macro read_int(%reg)
	li $v0, 5
	syscall
	move %reg, $v0
.end_macro

.macro print_int(%reg)
	move $a0, %reg
	li $v0, 1
	syscall
.end_macro

.macro exit()
	li $v0, 10
	syscall
.end_macro

.text
main:
	read_int($s0)
	
	li $s1, 1
	sw $s1, a
L1:
		li $t0, 0
		li $t1, 0
L2:
			lw $t2, a($t0)
			mulo $t2, $t2, $s1
			add $t2, $t2, $t1

			li $t3, 10
			div $t2, $t3
			mflo $t1
			mfhi $t2
			sw $t2, a($t0)

			addi $t0, $t0, 4
			blt $t0, 4096, L2

		addi $s1, $s1, 1
		ble $s1, $s0, L1

	li $t0, 4092
	li $t1, 0
L3:
		lw $t2, a($t0)
		or $t1, $t1, $t2
		beqz $t1, L4
		print_int($t2)
L4:
		subi $t0, $t0, 4
		bgez $t0, L3

	exit()