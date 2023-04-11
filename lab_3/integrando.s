main:
    #le num em a0
    addi t0, zero, 4
    ecall

    #guarda em s0
    add s0, zero, a0

    #se for zero vai para o fim
    beq s0, zero, fim 

    #faz operacao AND e guarda em s1, retorna 0 ou 1
    andi s1, s0, 1

    #verifica se eh par
    beq s1, zero, eh_par

    #se for impar soma em s3
    add s3, s3, s0
    j main

    #se for par soma em s2
    eh_par:
        add s2, s2, s0
        j main

    fim:
    sub a0, s3, s2 #impares-pares
    addi t0, zero, 1
    ecall
    ret

   