main:
    addi t0, zero, 4
    ecall

    #em s1 numero que sera verificado
    add s1, zero, a0

    #realiza operacao para ver se eh impar ou par e guarda em s2
    andi s2, s1, 1

    beq zero, s2, eh_par

    #se for impar guarda em a0 I
    addi a0, zero, 108

    #se for par guarda em a0 P
    eh_par:
        addi a0, zero, 80

    #imprime
    addi t0, zero, 2
    ecall

    ret

