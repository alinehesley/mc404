#RA: 248490
#Nome completo: Aline Hesley Silva Sousa

#Tarefa: Utilizar a tela do robô (12 x 16) para mostrar meu RA: 248490

.data
    vetor: .word 0x0, 0x0, 0x1CA729CE, 0x4A5294A, 0x4A5294A, 0x1CE739CA, 0x1025084A, 0x1025084A, 0x1C27084E, 0x0, 0x0, 0x0
.text 

main:
   addi sp, sp, -16 #guarda o ra (antes da main) e registradores s
    sw s0, 12(sp)
    sw s1, 8(sp)
    sw s2, 4(sp)
    sw ra, 0(sp)

    li s0, 12 #num total linhas
    li s1, 0 #para iterar as colunas

    coluna: 

    addi s1, s1, 1 #percorre as colunas
    li t0, 32 #qnt de colunas que uso para escrever meu ra
    bne s1, t0, nao_zera_coluna #se n estiver na última coluna
    li s1, 0 #zera a coluna

        nao_zera_coluna:
        addi s2, zero, 0 #zera a linha

    linha: 

    mv a0, s2 #recebe linha
    mv a1, s1 #recebe coluna

    call robo 

    #equanto a linha for dif num_linhas
    addi s2, s2, 1
    bne s2, s0, linha
    #sai da linha

    li a0, 250
    call pausa 

    j coluna

    #nunca é carregado, tá em loop infinito
    lw s0, 12(sp)
    lw s1, 8(sp)
    lw s2, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 16



robo: #a0 -> linha a1-> coluna
    addi sp, sp, -16
    sw s0, 12(sp)
    sw s1, 8(sp)
    sw s2, 4(sp)
    sw ra, 0(sp)

    la t0, vetor 
    li t2, 4 
    mul t1, a0, t2 #t1 -> linha * 4
    add t0, t0, t1 
    lw t0, 0(t0)

    li t2, 17
    blt a1, t2, antes_metade

    depois_metade:


    j fim_robo


    antes_metade: 
        li t2, 16
        sub t1, t2, a1
        srl t2, t0, t1
        li t3, 0xffff
        and t2, t2, t3

        li t3,11
        sub a1, t3, a0

        mv a2, t2
        li a0, 0x110
        ecall
        j fim_robo



    fim_robo:

    lw s0, 12(sp)
    lw s1, 8(sp)
    lw s2, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 16

    ret


pausa:
    addi sp, sp, -16
    sw s0, 12(sp)
    sw s1, 8(sp)
    sw s2, 4(sp)
    sw ra, 0(sp)

    loop_pausa:

    addi a0, a0, -1
    bge a0, zero, loop_pausa

    lw s0, 12(sp)
    lw s1, 8(sp)
    lw s2, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 16

    ret