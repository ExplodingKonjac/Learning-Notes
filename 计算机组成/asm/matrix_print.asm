.data
arr: .space 10000
sp: .asciiz " "
nl: .asciiz "\n"

.macro printsp(%x)
	li $v0, 1
	move $a0, %x
	syscall
	li $v0, 4
	la $a0, sp
	syscall
.end_macro

.macro println(%x)
	li $v0, 1
	move $a0, %x
	syscall
	li $v0, 4
	la $a0, nl
	syscall
.end_macro

.text
li $v0, 5
syscall
move $s0, $v0 # n
li $v0, 5
syscall
move $s1, $v0 # m

li $t0, 0
mul $t1, $s0, $s1

L1:
	li $v0, 5
	syscall
	sll $t2, $t0, 2
	sw $v0, arr($t2)
	addi $t0, $t0, 1
	bne $t0, $t1, L1

sll $t2, $t0, 2
move $t0, $s0
L2:
	move $t1, $s1
L3:
		subi $t2, $t2, 4
		lw $t3, arr($t2)
		beqz $t3, L4
		printsp($t0)
		printsp($t1)
		println($t3)
L4:
		subi $t1, $t1, 1
		bnez $t1, L3
	subi $t0, $t0, 1
	bnez $t0, L2

# exit
li $v0, 10
syscall
