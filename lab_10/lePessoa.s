# Faça uma função Pessoa* LePessoa() que 
# aloque memória para uma estrutura Pessoa, 
# leia os dados de uma pessoa (nome e idade) e 
# retorne essa estrutura.
# Deixe o campo prox com NULL (valor 0).

main:
    addi sp, sp, -12
    sw s1, 8(sp)
    sw s0, 4(sp)
    sw ra, 0(sp)

    call LePessoa #aloca memoria p uma estrutura Pessoa
    #devolve endereço em a0
    mv s0, a0

    #chamo LeString p nome
    call LeString

    #chamo LeNumero p idade
    addi a0, s0, 50 #posição 50° (depois do espaço que guardei p o nome)
    call LeNumero

    lw ra, 0(sp) #carrega o valor de ra da main
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12

    #encerra programa
    li a0, 10
    ecall         
    ret

LePessoa:
    #aloco memória 
    #nome 50
    #idade (num)
    li a1, 58 #str[50] + 2 int (8 bytes)
    li a0, 9 #chamada p alocar memoria
    ecall
    ret

LeString:

    addi sp, sp, -16 #guarda sp da main
    sw s2, 12(sp)
    sw s1, 8(sp)
    sw s0, 4(sp)
    sw ra, 0(sp)

    mv s0, a0 #carregando str em s0
    mv s2, a0 #ponteiro p o começo da str
     
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
        mv a0, s2

    fim:
    lw ra, 0(sp) #carrega o valor de ra da main
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    addi sp, sp, 16
    ret

#recebe em a0 -> s0 (estrutura pessoa) + 50
LeNumero:
    addi sp, sp, -32 
    sw s1, 8(sp)
    sw s0, 4(sp)
    sw ra, 0(sp)

    mv s0, a0 #posicao 50°

    addi a0, sp, 12
    call LeString #signica ler string 
    
    #addi a0, sp, 12
    call ConverteNumero

    sw a0, 0(s0)

    lw ra, 0(sp) #carrega o valor de ra da main
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 32
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

ImprimePessoa: #recebe em a0 ponteiro para Pessoa
    addi sp, sp, -12
    sw s1, 8(sp)
    sw s0, 4(sp)
    sw ra, 0(sp)

    # imprimo string
    call 
    # avanco 50 posições
    # imprimo numero

    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12
    ret

ImprimeNome: #recebe em a0 o endereco da string
    #le os caracteres


