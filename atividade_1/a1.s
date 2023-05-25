#RA: 248490
#Nome completo: Aline Hesley Silva Sousa

#Tarefa: Utilizar a tela do robô (12 x 16) para mostrar meu RA: 248490

.data
    vetor: .word 0x0, 0x0, 0x1CA729CE, 0x4A5294A, 0x4A5294A, 0x1CE739CA, 0x1025084A, 0x1025084A, 0x1C27084E, 0x0, 0x0, 0x0
.text 

main:
    addi sp, sp, -20 #guarda o ra (antes da main) e registradores s
    sw s0, 16(sp)
    sw s1, 12(sp)
    sw s2, 8(sp)
    sw s3, 4(sp)
    sw ra, 0(sp)

    li s0, 12 #num total linhas
    li s1, 0 #para iterar as colunas

    coluna: 
    addi s1, s1, 1 #percorre as colunas
    li t0, 48 
    bge s1, t0, fim

    addi s2, zero, 0 #zera a linha

    linha: 
    mv a0, s2 #recebe linha
    mv a1, s1 #recebe coluna

    call robo 

    addi s2, s2, 1
    bne s2, s0, linha #se n estiver na última linha, continuo percorrendo

    li a0, 200
    call pausa 

    j coluna

    fim:
    lw s0, 16(sp)
    lw s1, 12(sp)
    lw s2, 8(sp)
    lw s3, 4(sp)
    lw ra, 0(sp)
    addi sp, sp, 20
    
    li a0, 10 #encerra o programa
    ecall   
    ret

robo: #a0 -> linha a1-> coluna

    la t0, vetor 

    li t2, 4 
    mul t1, a0, t2 #t1 -> linha * 4
    add t0, t0, t1 
    lw t0, 0(t0)

    li t4, 32 #qnt total colunas

    bltu a1, t4, menor_igual #se for a1 <= 32 

    #se for maior que 32
    addi t5, a1, -32 
    sll t2, t0, t5

    j imprime

    menor_igual:
    sub t5, t4, a1
    srl t2, t0, t5
    
    imprime:

    li t3, 0xffff #mascara 111..111
    and t2, t2, t3
    li t3, 11

    sub a1, t3, a0 #numero da linha
    mv a2, t2 #leds
    li a0, 0x110 #ecall da tela do robô
    ecall

    fim_robo:
    ret

pausa:
    addi a0, a0, -1
    bge a0, zero, pausa
    ret