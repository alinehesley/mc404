.data
vetor:
    .word 1
    .word 2
    .word 3
    .word 4
    .word 5
.text

main:

    addi sp, sp, -4
    sw ra, sp, 0 #guardando o ra na pilha que estava antes da main

    lui s0, %hi(vetor) #carregando endereco vetor em s0
    addi s0, s0, %lo(vetor)


    # a0 - num_vetor
    addi a0, zero, 5

    # a1 - endereco vetor
    add a1, zero, s0
       
    # a2 - fator de multiplicacao
    addi a2, zero, 10

    call MultiplicaVetor # jal ra, MultiplicaVetor aqui eu mudo o ra

    lw ra, sp, 0
    addi sp, sp, 4
    ret




Multiplica:
    #Multiplica todos os numeros do vetor pelo fator 10
    #vetor esta guardado em s0, vou ir descendo nessa posicao
    
    mv t0, a1 #a1=10
    addi t1, zero, 0

    for_mul:
        beq t0, zero, fim_multiplica
        add t1, t1, a0 #multplico somando kkkk
        addi t0, t0, -1
        j for_mul

    fim_multiplica:
        mv a0, t1
        ret 


MultiplicaVetor:
    # Movimenta o apontador da pilha 4 posicoes para baixo (16 bytes) e guarda 4 registradores na pilha
    addi sp, sp, -16
    sw   s0, sp, 12 #guardo pq vou usar essa bagaca poderia fazer folha ne meu fi
    sw   s1, sp, 8
    sw   s2, sp, 4
    sw   ra, sp, 0 #ra eh pra onde meu programa volta quando tem um ret

    #colocando valores nos registradores que guardei na pilha paranetro
    mv   s0, a0 #N
    mv   s1, a1 #v
    mv   s2, a2 #fator

    for:
        beq  s0, zero, fim #pq estou decrementando s0

        lw   a0, s1, 0 #escrevendo em a0 o valor de s1 (primeira posicao vetor)
        mv   a1, s2 #a1 recebe s2 fator

        call Multiplica #a0 parametro x (vetor), a1 eh y(fator)
        sw   a0, s1, 0 #a0 (resposta) escreve no v

        addi t0, zero, 1
	    ecall


        addi s1, s1, 4 #s1 vai para a proxima posicao da memoria
        addi s0, s0, -1 #decrementa o s0
        j    for

    fim:
        # Movimenta o apontador da pilha 4 posicoes para cima (16 bytes) e recupera 4 registradores da pilha
        lw   ra, sp, 0
        lw   s2, sp, 4
        lw   s1, sp, 8
        lw   s0, sp, 12
        addi sp, sp, 16
        ret