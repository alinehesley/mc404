#se eu ativar o bit  5 de uma letra minuscula
#ela sera transformada em maiscula

#ativar com a operacao OU com ORI - unsando imediati 32

#desativa fazendo operacaO E com ANDI - usando o imediato 222


main:
	#le um caractere maiusculo em a0
	addi t0, zero, 5
	ecall

	#transforma em minusculo com ANDI
	#addi a0, a0, -32 pq assim n pode
	ori a0, a0, 32

	#imprime caractere em minusculo
	addi t0, zero, 2
	ecall

	ret
