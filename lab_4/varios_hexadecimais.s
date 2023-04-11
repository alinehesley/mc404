main:
	#leia varios numeros e guarde em um registrador
	#imprimir cada numero usando hexadecimal
	#usando 8 digitos

	#num_decimal copio p um registrador 
	#descolo esse numero de 28 bits aplico mascara de 15(1111)

	#le num em a0
	addi t0, zero, 4
	ecall

	#guarda num em s0s
	add s0, zero, a0

	#preciso deslocar 2 vezes 4 bits SRLI rd, rs1, imm
	srli s0, s0, 4
	and s1, s0, 15 #ANDI rd, rs1, imm

	#coloca numero p imprimir em a0
	add a0, zero, s1