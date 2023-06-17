.data
    buffer: .space 256 
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

    mv s0, a0
    #imprimo a string 
    li a0, 4
    mv a1, s0
    #addi a1,a1,1
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
    addi sp, sp, -16 #guarda sp da main
    sw s2, 12(sp)
    sw s1, 8(sp)
    sw s0, 4(sp)
    sw ra, 0(sp)

    mv s0, a0 #carregando str em s0
    mv t1, a0
    li t0, 0

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

    #aloco memoria
    li a0, 9
    mv a1, t0
    ecall
    
    mv s2, a0 #guardo a possicao q foi alocada dinamicamente
    mv a1, t1
    call strcpy

    fim_lestr:
    mv a0, s2 
    lw ra, 0(sp) #carrega o valor de ra da main
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    addi sp, sp, 16
    ret

strcpy:
    addi sp, sp, -16 #guarda sp da main
    sw s2, 12(sp)
    sw s1, 8(sp)
    sw s0, 4(sp)
    sw ra, 0(sp)

    #carrega str1 em s1 - memoria alocada dinamicamente
    mv s1, a0

    #carrega str2 em s2 - buffer
    mv s2, a1

    strcpy_loop:

    lbu t1, 0(s2) #leio primeiro char de str2 em t1
    sb t1, 0(s1) #escrevo em str1

    addi s1, s1, 1 #ando em s1 e s2
    addi s2, s2, 1

    lbu t2, 0(s2)

    bne t2, zero, strcpy_loop
    
    fim_strcpy:
    lw ra, 0(sp) #carrega o valor de ra da main
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    addi sp, sp, 16
    ret
    