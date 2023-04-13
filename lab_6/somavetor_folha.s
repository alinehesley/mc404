.data
vetor: #vetor de elementos
    .word 1
    .word 2
    .word 3
    .word 4
    .word 5
.text

main:
    addi sp, sp, -4
    sw ra, sp, 0 #escrevendo o ra na pilha

    lui s0, %hi(vetor)
    addi s0, s0, %lo(vetor)

    # a0 - N
    addi a0, zero, 5

    # a1 - *v
    add a1, zero, s0

    call SomaVetor # jal ra, SomaVetor mudando o valor de ra

    add a0, t1, zero
    addi t0, zero, 1
    ecall

    lw ra, sp, 0 #carrega o valor de ra q estava antes da main
    addi sp, sp, 4
    ret

Soma:
    #Faz o somatorio de todos os elementos do vetor
    add t1, t1, t2
    ret


SomaVetor:

    addi sp, sp, -4
    sw   ra, sp, 0 #guardando o valor de ra q tem na main

    addi t1, zero, 0 #acumulador da soma
    addi t2, zero, 0 #elementos

    #ja estou usando o proprio a0 e a1 como parametro

    for:
        beq  a0, zero, fim #decrementando N

        lw   t2, a1, 0 #escrevendo em t2 o valor q esta em na posicao a1

        call Soma #guardando o valor de ra da prox linha

        addi a1, a1, 4 #s1 vai para a proxima posicao da memoria
        addi a0, a0, -1 #decrementa o s0

        j    for

    fim:
        lw   ra, sp, 0 #carrega o valor de ra da main
        addi sp, sp, 4
        ret