.data
p: .space 8
vis: .space 8

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

.macro push(%reg)
	subi $sp, $sp, 4
	sw %reg, 0($sp)
.end_macro

.macro pop(%reg)
	lw %reg, 0($sp)
	addi $sp, $sp, 4
.end_macro

.macro println()
	li $v0, 11
	li $a0, 10
	syscall
.end_macro

.macro exit()
	li $v0, 10
	syscall
.end_macro

.text

main:
	read_int($s0) # s0: n
	move $a0, $s0
	li $a1, 0
	jal dfs
	exit()

dfs: # (n: int, cur: int) -> void
	push($ra)
	push($s0)
	push($s1)
	move $s0, $a0
	move $s1, $a1
	blt $s1, $s0, L2
	li $t0, 0
L1:
		lb $t1, p($t0)
		addi $t1, $t1, 1
		print_int($t1)
		printsp()
		addi $t0, $t0, 1
		blt $t0, $s0, L1
	println()
	j L5
L2:
	li $t0, 0
L3:
		lb $t1, vis($t0)
		bnez $t1, L4
			li $t1, 1
			sb $t1, vis($t0)
			sb $t0, p($s1)
			push($t0)
			move $a0, $s0
			addi $a1, $s1, 1
			jal dfs
			pop($t0)
			sb $0, vis($t0)
			sb $0, p($s1)
L4:
		addi $t0, $t0, 1
		blt $t0, $s0, L3
L5:
	pop($s1)
	pop($s0)
	pop($ra)
	jr $ra
