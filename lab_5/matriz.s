.data
vetor:
	.word 0 
	.word 0 
	.word 0
	.word 0
	.word 0
	.word 0
.text

main:
	#matriz 2 x 3
	#preencher a posicao i,j com o valor (i+j)
	lui s0, %hi(vetor) #carregando o vetor
	addi s0, s0, %lo(vetor)


	addi t0, zero, 2 #linha
	addi t1, zero, 3 #coluna
	addi t3, zero, 0 #cont_linha
	addi t4, zero, 0 #cont_coluna
	addi t5, zero, 0 #possui a soma

	#comeco na linha 0 
		coluna:
			add t5, t4, t3 #soma linha e coluna
			sw t5, s0, 0 #escrevo no vetor a soma

			addi t4, t4, 1 #ando na coluna
			addi s0, s0, 4 #ando no vetor
			beq t4, t1, prox_linha #se for a ultima coluna da linha vai p prox linha
			j coluna
		
		prox_linha:
			addi t3, t3, 1
			addi t4, zero, 0
			beq t3, t0, fim #se for ultima linha vai p fim t3 == t0
			j coluna

	#vou percorrendo a coluna 
	#troco a linha qnd chegar no fim da coluna
	fim:
		ret

	
