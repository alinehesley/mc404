.data
    buffer: .space 256   # Buffer global para armazenar a string inicialmente

.text 

main:
    addi sp, sp, -12 #guarda sp da main
    sw s1, 8(sp)
    sw s0, 4(sp)
    sw ra, 0(sp)

    #função leString que lê uma string
    #do teclado 
    #e retorna a posição de memória do buffer
    la a0, buffer
    call LeString #lê string e coloca em buffer
    #LeString retorna a string ok e a qnt de caracteres

    #aloco uma nova memória com espaço correto
    #LeString ja retorna a1
    li a0, 9 #chamada
    ecall #devolve em a0 a posicao alocada

    mv s0, a0

    #copio a str q está no buffer p o novo espaço de memória
    la a1, buffer
    call Strcpy

    #imprimo a string 
    li a0, 4
    mv a1, s0
    ecall

    lw ra, 0(sp) #carrega o valor de ra da main
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12

    #encerra programa
    li a0, 10
    ecall         
    ret

LeString:
    addi sp, sp, -12 #guarda sp da main
    sw s1, 8(sp)
    sw s0, 4(sp)
    sw ra, 0(sp)

    li t0, 0

    mv s0, a0 #carregando str em s0
    mv t1, a0
     
    li s1, 0x01

    li a0, 0x130
    ecall

    loop_leitura:
        li a0, 0x131
        ecall

        beq a0, zero, tudo_lido
        beq a0, s1, loop_leitura
        #lendo caracter
        sb a1, 0(s0)
        addi s0, s0, 1
        addi t0, t0, 1
        j loop_leitura
    
    tudo_lido:
        sb zero, 0(s0) #add \0 no final da string
        addi t0, t0, 1

    fim_lestring:
    mv a0, t1
    mv a1, t0
    lw ra, 0(sp) #carrega o valor de ra da main
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12
    ret

#usa a função strcpy


Strcpy:
    addi sp, sp, -12 #guarda sp da main
    sw s1, 8(sp)
    sw s0, 4(sp)
    sw ra, 0(sp)

    #carrega str1(a0) em s1 (alocada)
    la s1, a0

    #carrega str2(a1) em s2 (buffer)
    la s2, a1

    lbu t1, 0(s2) #leio primeiro char de str2 em t1
    sb t1, 0(s1) #escrevo em str1

    addi s1, s1, 1 #ando em s1 e s2
    addi s2, s2, 1

    lbu t2, 0(s1)

    bne t2, zero, Strcpy

    fim_strcpy:
        lw ra, 0(sp) #carrega o valor de ra da main
        lw s0, 4(sp)
        lw s1, 8(sp)
        addi sp, sp, 12
        ret
