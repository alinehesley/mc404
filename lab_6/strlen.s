main:
    addi sp, sp, -4
    sw ra, sp, 0 #escrevendo o ra na pilha

    addi  t0, zero, 6 #le uma string do teclado e guarda em a0
    ecall

    call strlen

    addi t0, zero, 1 #imprime
    ecall

    lw ra, sp, 0 #carrega o valor de ra q estava antes da main
    addi sp, sp, 4
    ret

strlen:
    addi t0, zero, 0 #contador

    strlen_loop:
        lbu t1, a0, 0 #t1 eh vetor *s
        beq t1, zero, str_end #igual a espaco
        addi t0, t0, 1 #somando no cont
        addi a0, a0, 1 #andando no vetor
        j strlen_loop

str_end:
    add a0, zero, t0 #movendo o cont p a0
    ret
