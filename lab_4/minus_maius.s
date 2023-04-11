verifica_maiuscula:
	#letra maiuscula maior ou igual 65 e menor ou igual 90
	addi a0, zero, 65
	bge s1, a0, verifica_menorq90
	j verifica_minuscula

	verifica_menorq90:
		addi a0, zero, 91
		blt s1, a0, eh_maiuscula
		#j verifica_minuscula n volta p a main
	
verifica_minuscula:
	#letra minuscula maior ou igual 97 e menor ou igual 122
	addi a0, zero, 97
	bge s1, a0, verifica_menorq122
	j nao_eh_nada

	verifica_menorq122:
		addi a0, zero, 123
		blt s1, a0, eh_minuscula
		j nao_eh_nada

main:
	#le caractere do teclado e guarda em a0
	addi t0, zero, 5
	ecall

	#guarda caractere em s1
	add s1, zero, a0 

	j verifica_maiuscula
	verifica_minuscula

	nao_eh_nada:
		j imprime

	#passa p minuscula
	eh_minuscula:
		andi s1, s1, 223
		j imprime

	#passa p minuscula
	eh_maiuscula: 
		ori s1, s1, 32	

	#imprime caractere
	imprime:
		add a0, zero, s1
		addi t0, zero, 2
		ecall
		ret


#se for minuscula imprime maiuscula
#se for maiuscula imprime minuscula
#caso contrario imprima os caracteres sem
#modificacao

#como sei se eh uma letra maiuscula
#A 65 e Z 90
#como sei se eh uma letra minuscula
#a 97 e z 122

#INTERVALO QUE ESTA CONTIDO NA TABELA ASCII