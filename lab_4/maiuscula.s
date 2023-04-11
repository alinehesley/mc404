main:
	#le caractere em minisculo 
	addi t0, zero, 5
	ecall

	#passa de minusculo para maiusculo
	andi a0, a0, 223

	#imprime caractere em maiusculo
	addi t0, zero, 2
	ecall