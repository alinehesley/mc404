main:
    #le num
    addi t0, zero, 4
    ecall

    #guarda num em s0
    add s0, zero, a0

    li s6, 2147483648 #vou deslocar

    addi s4, zero, 31 #s4 = 32

    loop:
        blt s4, zero, fim #vai fazer 32x

    operacao: 
        and s5, s6, s0 #s6 and s0 = s5

        bne s5, zero, imprime_1

        imprime_0:
            addi a0, zero, 0
            addi t0, zero, 1
            ecall
            j desloca
        
        imprime_1:
            addi a0, zero, 1
            addi t0, zero, 1
            ecall

        desloca:
            srli s6, s6, 1
            addi s4, s4, -1 #iteracao
            j loop
    
    fim:
        ret
