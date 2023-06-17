.data
    str: .space 20
.text 

main:
    #precisa guardar ra??
    
    call le_string
    call imprime_str

    #encerra a execução do programa
    addi a0, zero, 10
    ecall


le_string:
    addi sp, sp, -8
    sw s0, 4(sp)
    sw ra, 0(sp)

    la s0, str #carrego o espaço onde vou colocar a str em s0

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
        li t3, 10
        sb t3, 0(s0) #quebra de linha
        addi s0, s0, 1

        sb zero, 0(s0) #coloca 0
        
    lw ra, 0(sp) #precisa? eu n chamo nenhuma funcao aq
    lw s0, 4(sp)
    addi sp, sp, 8
    ret

imprime_str: 
    li a0, 4
    la a1, str
    ecall
    ret