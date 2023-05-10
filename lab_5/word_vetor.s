.data
vetor:
	.word 10
	.word 20
	.word 30

vetor_2:
	.word 3

.text #voltando a utilizar a regiao de memoria p codigo do programa

main:
	lui s0, %hi(vetor) #o que eh hi  lui carrega os bits 20 mais significativos 
	addi s0, s0, %lo(vetor) #o que eh lo  addi complementa o endereco com bits menos significativos

	lui s1, %hi(vetor_2) #o que eh hi  lui carrega os bits 20 mais significativos 
	addi s1, s1, %lo(vetor_2) #o que eh lo  addi complementa o endereco com bits menos significativos

	lw t0, s0, 0 #pego v[0] e coloco em t0
	addi t0, t0, 1 #incremento 1
	sw t0, s0, 0 #escrevendo em v[0] meu novo valor incrementado t0

	lw t1, s0, 4
	addi t1, t1, 1
	sw t1, s0, 4


	lw t2, s0, 8
	addi t2, t2, 1
	sw t2, s0, 8

	#eu incrementei o 1 na regiao da memoria, posicao de cada vetor
	#mas n estou imprimindo necessariamente o que esta la
	#estou imprimindo o que esta na variavel
	#como faco para imprimir verdadeiramente o novo vetor

	lw a0, s0, 0
	addi t0, zero, 1
	ecall

	lw a0, s0, 4
	addi t0, zero, 1
	ecall

	lw a0, s0, 8
	addi t0, zero, 1
	ecall
	

ret