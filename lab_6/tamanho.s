main:
    addi sp, sp, -4
    sw ra, sp, 0 #escrevendo o ra na pilha q estava antes da main

    call Tamanhostring

    add a0, zero, t0 #movendo o cont p a0

    addi t0, zero, 1 #imprime
    ecall

    lw ra, sp, 0 #carrega o valor de ra q estava antes da main
    addi sp, sp, 4

    ret

Tamanhostring:
    addi sp, sp, -24
    sw ra, sp, 0 #escrevendo o ra da main na pilha
    addi a0, sp, 4 #posicao q do primeiro elemento da string

    #parametros do ecall a0 e a1
    addi a1, zero, 20 #tam max string

    addi  t0, zero, 6 #le uma string do teclado
    ecall

    #parametros a0, a1
    call strlen

    addi t0, zero, 1
    ecall

    lw ra, sp, 4 #carrega o valor de ra q estava antes da main
    addi sp, sp, 24
    ret

strlen: #int strlen(char *s)
    addi t0, zero, 0 #contador
    loop:

    lbu t1, a0, 0 #t1 eh vetor *s
    addi t2, zero, 32 #cod ASCII do espaco

    beq t1, t2, fimstrlen #igual a espaco

    addi t0, t0, 1 #somando no cont
    addi a0, a0, 1 #andando no vetor

    j loop

    fimstrlen:
    add a0, zero, t0
    ret

    
