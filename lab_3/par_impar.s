main:
    #le numero em a0
    addi t0, zero, 4
    ecall

    #guarda num lido em s0
    add s0, zero, a0

    #faz operacao AND e guarda em s1
    andi s1, s0, 1

    #verifica se eh par
    beq s1, zero, eh_par

    #coloca I em a0
    addi a0, zero, 73
    j imprime

    eh_par:
        #coloca P em a0
        addi a0, zero, 80
    
    imprime:
        addi t0, zero, 2
        ecall
        ret



    
