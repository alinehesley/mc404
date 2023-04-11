main:
    #le um numero
    addi t0, zero, 4
    ecall

    #guarda num em s1
    add s1, zero, a0

    #verifica se eh multiplo de 4, guarda em s2 0 ou 1
    #formula a%b = a AND (b-1)
    andi s2, s1, 3

    #verifica se eh multiplo de 4 ou n
    beq s2, zero, eh_multiplo4

    addi a0, zero, 78
    j imprime

    eh_multiplo4:
        addi a0, zero, 83

    imprime:
    addi t0, zero, 2
    ecall
    ret


    