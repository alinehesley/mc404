main:
    #le segredo
    addi t0, zero, 4
    ecall

    #guarda segredo em s1
    add s1, zero, a0

    #le num p codificar
    addi t0, zero, 4
    ecall

    #guarda num a ser codificado em s2
    add s2, zero, a0

    #codifica em a0
    xor a0, s2, s1

    #imprime num codificado
    addi t0, zero, 1
    ecall