main:


    addi  t0, zero, 6 #le uma string do teclado
    ecall

strlen:
    addi t0, zero, 0 #contador

    strlen_loop:
        lbu t1, a0, 0 #t1 eh vetor *s
        beq t1, #igual a espaco, str_end
        addi t0, t0, 1
        addi a0, a0, 4 #andando no vetor
        j strlen_loop

str_end:
    ret


#li a0, 1
#add t0, zero, 1