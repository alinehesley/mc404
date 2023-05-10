main:
	#le caractere em minisculo 
	addi t0, zero, 5
	ecall

	#passa de minusculo para maiusculo
	#andi a0, a0, 223 funciona
	addi a0, a0, -32 #assim eh melhor faz mais sentido p mim

	#imprime caractere em maiusculo
	addi t0, zero, 2
	ecall