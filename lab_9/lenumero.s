#funcao q le numero do teclado e retorna esse num

.data
    str: .space 20
.text

main:
    addi sp, sp, -4
    sw ra, 0(sp) #salvar ra
    la a0, str

    call LeString #signica ler string 

    la a0, str
    call ConverteNumero
    mv a1, a0 #ecall usa a0, imprime o q esta no a1

    #imprime num
    li a0, 1 #no a1 precisa estar o num
    ecall
    
    lw ra, 0(sp) #le o ra q estava antes da main
    addi sp, sp, 4 

    #encerra o programa
    li a0, 10
    ecall       
    ret

LeString:
    addi sp, sp, -12 #guarda sp da main
    sw s1, 8(sp)
    sw s0, 4(sp)
    sw ra, 0(sp)

    mv s0, a0 #carregando str em s0
     
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
        j loop_leitura
    
    tudo_lido:
        sb zero, 0(s0) #add \0 no final da string

    fim:
    lw ra, 0(sp) #carrega o valor de ra da main
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12
    ret
    

ConverteNumero:
    mv t0, zero #resposta
    li t2, 10

    loop:
        lbu t1, 0(a0)
        beq t1, zero, fim_str
        addi a0, a0, 1
        addi t1, t1, -48 #converte p num
        #concatenacao
        mul t0, t0, t2 #mul por 10
        add t0, t0, t1 #soma
        j loop

    fim_str:
        mv a0, t0

    ret



