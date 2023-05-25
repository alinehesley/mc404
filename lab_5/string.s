.data
string: #vetor de 20 bytes
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
    .byte 0
.text #voltando p regiao da memoria q escreve o codigo

main:
    lui a0, %hi(string)
    addi a0, a0, %lo(string)

    addi a1, zero, 20 #tam max da string q vou ler

    addi t0, zero, 6 #le string do teclado usa dois parametros a0 e a1
    ecall

    lui a0, %hi(string) #carregando novamente para garantir
    addi a0, a0, %lo(string)

    addi t1, zero, 0 #cont letras

    conta_string: 
        lbu t2, a0, 0 #passa a letra p t2
        addi a0, a0, 1 #vai p prox letra

        #se t2 for igual a espaco ou igual a 0 vai p o fim
        beq t2, zero, fim 
        addi t4, zero, 32 #se for 20 ja vai p fim
        beq t2, t4, fim #bne
        addi t1, t1, 1 #incrementando cont
        j conta_string

fim:
    ret

    #y: 10010101
    #lw : lixoxolxdoekw 10010101

    #lb: 11111111...10010101

    #lbu: 000000...010010101


    