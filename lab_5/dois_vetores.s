.rodata
vetor_1:
	.word 1 #0
	.word 2 #4
	.word 3 #8
	.word 4 #12
	.word 5 #16

vetor_2:
	.word 6 #0
	.word 7 #4
	.word 8 #8
	.word 9 #12
	.word 10 #16

.data
vetor_3:
	.word 0 #0
	.word 0 #4
	.word 0 #8
	.word 0 #12
	.word 0 #16

.text

main:

	lui s0, %hi(vetor_1)
    addi s0, s0, %lo(vetor_1) #ta guardando so o tamanho 20 bits

    lui s1, %hi(vetor_2)
    addi s1, s1, %lo(vetor_2)

    lui s2, %hi(vetor_3)
    addi s2, s2, %lo(vetor_3)

	addi s4, zero, 5 #cont

	loop:
	 	beq s4, zero, fim
		lw t0, s0, 0 #vetor_1[0]
		lw t1, s1, 0 #vetor_2[0]
		add t3, t0, t1 #t3 = vetor_1[0] + vetor_2[0]
		sw t3, s2, 0 #escreve em vetor_3[0] o valor de t3

		#imprime
		lw a0, s2, 0
		addi t0, zero, 1
		ecall

		addi s0, s0, 4
		addi s1, s1, 4
		addi s2, s2, 4
		addi s4, s4, -1
		j loop
fim:
ret

