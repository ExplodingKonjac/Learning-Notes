li $v0, 5
syscall
move $s0, $v0

li $t0, 4
div $s0, $t0
mfhi $t0
bnez $t0, not_leap

li $t0, 100
div $s0, $t0
mfhi $t0
bnez $t0, leap

li $t0, 400
div $s0, $t0
mfhi $t0
beqz $t0, leap
j not_leap

leap:
li $a0, 1
li $v0 1
syscall
li $v0, 10
syscall

not_leap:
li $a0, 0
li $v0 1
syscall
li $v0, 10
syscall
