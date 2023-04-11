.data
vetor:
	.word 10
	.word 20
	.word 30

.text #voltando a utilizar a regiao de memoria p codigo do programa

main:
	lui s0, %hi(vetor) #o que eh hi  lui carrega os bits 20 mais significativos 
	addi s0, s0, %lo(vetor) #o que eh lo  addi complementa o endereco com bits menos significativos

	lw t0, s0, 0 #carrega uma palavra 32 bits da memoria p um registrador
	#nesse caso esta carregando a primeira posicao do vetor p t0

	lw t1, s0, 4
	lw t2, s0, 8

	add t3, t0, t1
	add t3, t3, t2

	add a0, t3, zero

	addi t0, zero, 1
	ecall