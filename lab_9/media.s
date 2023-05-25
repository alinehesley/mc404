#Tarefa: função int Media (int *v, int N)

.data
    str: .space 10 #espaco para ler a str
    vetor: .space 40 #espaço q sera armazenado o vetor
.text

main:
    addi sp, sp, -4
    sw ra, 0(sp) #guarda ra q estava antes da main

    #LeVetor recebe como parametros o vetor em que vou armazenar e a qnt numeros
    la a0, vetor
    li a1, 2

    call LeVetor

    la a0, vetor
    li a1, 2

    call Media

    mv a1, a0
    #imprime num
    li a0, 1 #no a1 precisa estar o num
    ecall

    #Encerra o programa 
    li a0, 10  
    ecall

    lw ra, 0(sp)
    addi sp, sp, 4

    ret


LeVetor:
    addi sp, sp, -12 
    sw s1, 8(sp)
    sw s2, 4(sp)
    sw ra, 0(sp)

    mv s1, a1 #qnt de vezes q vamos ler str
    mv s2, a0 #movendo o vetor q vou preencher c numeros

    lendo_numeros: 

    call LeNumero #devolve em a0 o numero

    sw a0, 0(s2)
    addi s2, s2, 4
    
    addi s1, s1, -1 #decrementando cont num

    bne s1, zero, lendo_numeros #leu e escrevou tds 10 numeros

    fim:
    
    lw ra, 0(sp)
    lw s2, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12
    ret


LeNumero:
    addi sp, sp, -4
    sw ra, 0(sp)

    call LeString #recebe em a1->qnt_num, devolve em a0 a str

    call ConverteNumero #recebe a0->str
    #devolve em a0 o numero convertido

    lw ra, 0(sp)
    addi sp, sp, 4
    ret

LeString:

    la t0, str #carrega str em t0
     
    li t1, 0x01

    li a0, 0x130
    ecall #desejo ler um caracter

    loop_leitura:
        li a0, 0x131
        ecall

        beq a0, zero, tudo_lido
        beq a0, t1, loop_leitura
        #lendo caracter
        sb a1, 0(t0)
        addi t0, t0, 1
        j loop_leitura
    
    tudo_lido:
        sb zero, 0(t0) #add \0 no final da string
        la a0, str
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

Media: 
    mv t0, a0 #recebo o vetor
    mv t3, a1 #qnt num
    mv t4, a1

    li t1, 0 #aux 
    li t2, 0 #somatorio

    loop_media:
        lw t1, 0(t0)
        add t2, t2, t1
        addi t0, t0, 4
        addi t3, t3, -1
        bne t3, zero, loop_media

    div a0, t2, t4
    ret