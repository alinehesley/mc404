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
	#preencher a posicao i,j com o valor (i+j)
	lui s0, %hi(vetor)
	add s0, s0, %lo(vetor)
  
	add t1, t1, zero #valor i (linha), mas n garanto q tem 0 em t0
	add t2, t2, zero #valor j (coluna)

	#qnt linha 
	addi s1, zero, 1
	addi s2, zero, 2

	bltu t1, s1, continua_linha

	continua_linha: 
		bltu t2, s2, continua_coluna
		continua_coluna:
			#primeiro somo t1+t2 (linha + coluna)
			add t3, t1, t2

			#descobre posicao do vetor (linha*coluna) + coluna
			add t4, 

			#escrevo esse valor na posicao do vetor
			sw t3, s0, #como escrevo imm de t4


			#escrevo esse valor na posicao vetor[t1][t2]

			#incrementa coluna 
			addi t2, t2, 1
		#incrementa linha
		addi t1, t1, 1

ret

	
