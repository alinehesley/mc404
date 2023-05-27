addi s0, s1, 20
slli t5, t0, 16 
xor a0, t5, s3
ret
lw s0, 8(s1)
sw a0, 0(s0)
mul s0, s1, t4
addi t5, s3, 99
slli s0, ra, 24 
xor t1, s11, t6
ret
lw a1, 8(a0)
sw a2, 0(s0)
mul s6, a7, zero
addi s0, zero, 0
slli s1, a2, 31
xor s8, s1, zero
ret
lw t3, 11(sp)
sw a3, 0(t1)
mul s9, ra, a0
lui a0, 0x87654