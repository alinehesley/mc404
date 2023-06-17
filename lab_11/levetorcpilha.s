.data
    str: .space 20
.text 

main:
    
    call le_vetor

    # call imprime_num #recebe como parametro o num

    #encerra a execução do programa
    li a0, 10
    ecall
    ret


le_vetor:
    addi sp, sp, -52 #vetor p 10 int + ra e s0
    sw ra, 48(sp)
    sw s1, 44(sp)
    sw s0, 40(sp)

    mv s0, sp #ponteiro p começo do vetor de 10 int

    loop_vetor:
        la a0, str
        call le_string #escreve direto no espaço q declarei str

        la a0, str #carrego novamente a str em a0 
        call converte_num #ja devolve num em a0

        #guardar no vetor e andar no vetor
        sw a0, 0(s0)
        addi s0, s0, 4

        bne a0, zero, loop_vetor
    
    
    mv s1, sp #referencia p começo do vetor
    
    loop_imprime:
         lw t0, 0(s1)
         beq t0, zero, fim_vetor

         li a0, 1
         mv a1, t0
         ecall
         
         addi s1, s1, 4
         j loop_imprime
         
    fim_vetor:

        lw s0, 40(sp)
        lw s1, 44(sp)
        lw ra, 48(sp)
        addi sp, sp, 52
        ret

# imprime_vetor: #recebe como parametro a0 referencia do comeco do vetor
#     addi sp, sp, -4
#     sw ra, 0(sp)

#     loop_imprime:
#         lw t0, 0(a0)
#         beq t0, zero, fim_vetor

#         call imprime_num
#         addi a0, a0, 4
#         j loop_imprime

#     fim_vetor:
#         lw ra, 0(sp)
#         addi sp, sp, 4
#         ret

le_string:
    addi sp, sp, -4
    sw s0, 0(sp)

    mv s0, a0 #carrego o espaço onde vou colocar a str em s0

    mv t0, zero #contador
    li t1, 0x01 #ainda lendo
    li t2, 0x02 #leu caracter

    #indica que quero ler caracter do teclado
    li a0, 0x130
    ecall

    loop_str: 
        li a0, 0x131 #verifica se tem caracter disponivel
        ecall

        beq a0, zero, fim_str
        beq a0, t1, loop_str
        beq a0, t2, leu_carctere
    
    leu_carctere:
        sb a1, 0(s0)
        addi s0, s0, 1 #anda na str
        addi t0, t0, 1 #incrementa cont
        j loop_str
    
    fim_str:
        sb zero, 0(s0) #coloca 0
        
    lw s0, 0(sp)
    addi sp, sp, 4
    ret


converte_num:
    mv t0, zero #vai ter a resposta
    li t4, 0
    li t1, 10 #fator de mul
    li t3, 45
    li t5, -1

    loop_num:
        lbu t2, 0(a0) #leio um caracter em t2
        beq t2, zero, fim_num #se for igual a o \n ja paro

        beq t2, t3, eh_traco #ativo a flag e volto p loop sem fazer nd

        addi t2, t2, -48 #converto p num
        mul t0, t0, t1 #vai colocando espaço, deslocando p esq
        add t0, t0, t2
        addi a0, a0, 1
        j loop_num

        eh_traco: #vou fazer tp uma flag
            li t4, 1
            addi a0, a0, 1
            j loop_num
        
    fim_num:
        beq t4, zero, eh_positivo
        mul t0, t0, t5 #se o num é negativo, mul a resp por -1
    
    eh_positivo:
        mv a0, t0 #devolve o num no a0
        ret

imprime_num:
    mv t0, a0

    li a0, 1
    mv a1, t0
    ecall
    ret