main:
	#le num do teclado entre 0 e 15 em a0
	addi t0, zero, 4
	ecall

	#guarda num lido no registrador s1
	add s1, zero, a0

	#se for maior ou igual 10, salta para nao_eh_numero
	addi s2, zero, 10
	bge s1, s2, nao_eh_numero
	
	#converte numero para hexadecimal
	nao_eh_letra:
		j imprime_num #qual o caso de precisar usar imm 48?

	nao_eh_numero:
		addi s1, s1, 55
		j imprime_letra

	#imprime numero
	imprime_num:
		add a0, zero, s1
		addi t0, zero, 1 #posso fazer com num 2
		ecall

	#imprime numero
	imprime_letra:
		add a0, zero, s1
		addi t0, zero, 2
		ecall

	#imprime letra h
	addi a0, zero, 104
	addi t0, zero, 2
	ecall