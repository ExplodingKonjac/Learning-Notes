# -------- data --------
.data
vis: .space 8 # bool vis[8]
e: .space 64  # bool e[8][8]

# ------- macros -------
.macro exit()
	li $v0, 10
	syscall
.end_macro

.macro read_int(%x)
	li $v0, 5
	syscall
	move %x, $v0
.end_macro

.macro print_int(%x)
	move $a0, %x
	li $v0, 1
	syscall
.end_macro

.macro push(%x)
	addiu $sp, $sp, -4
	sw %x, 0($sp)
.end_macro

.macro pop()
	addiu $sp, $sp, 4
.end_macro

.macro pop(%x)
	lw %x, 0($sp)
	pop()
.end_macro

# -------- text --------
.text

main: # main() -> ()
	read_int($s0) # n
	read_int($s1) # m
	li $s2, 0 # ans
	li $t0, 0
L1:
		read_int($t1) # u
		read_int($t2) # v
		subi $t1, $t1, 1
		subi $t2, $t2, 1
		li $t3, 1
		sll $t4, $t1, 3
		add $t4, $t4, $t2
		sb $t3, e($t4)
		sll $t4, $t2, 3
		add $t4, $t4, $t1
		sb $t3, e($t4)
		addi $t0, $t0, 1
		bne $t0, $s1, L1
	
	li $a0, 1
	li $a1, 0
	li $v0, 0
	jal dfs
	print_int($s2)

	exit()

dfs: # (int dep, int u) -> int
	bne $a0, $s0, L2
		sll $t1, $a1, 3
		lb $t1, e($t1)
		beqz $t1, L6
		li $s2, 1
		b L6
L2:
	push($a0)
	push($a1)
	push($ra)
	li $t0, 1
	sb $t0, vis($a1)
	li $t0, 0
	sll $t1, $a1, 3
	la $t1, e($t1)
L3:
		lb $t2, 0($t1)
		beqz $t2, L4
		lb $t2, vis($t0)
		bnez $t2, L4
		lb $t2, 8($sp)
		addi $a0, $t2, 1
		move $a1, $t0
		push($t0)
		push($t1)
		jal dfs
		pop($t1)
		pop($t0)
		bnez $s2, L5
L4:
		addi $t0, $t0, 1
		addi $t1, $t1, 1
		bne $t0, $s0, L3
L5:
	pop($ra)
	pop($a1)
	pop()
	sb $0, vis($a1)
L6:
	jr $ra
