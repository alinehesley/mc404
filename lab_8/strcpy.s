#implementa a função char * strcpy(char *s1, char *s2)
#que copia o conteúdo da s2 para s1

#declarar duas strings
.data
    str1: .string "bolo"
    str2: .string "cake"

.text
#usa a função strcpy
main:

    #carrega str1 em s1
    la s1, str1

    #carrega str2 em s2
    la s2, str2

strcpy:
    lbu t1, 0(s2) #leio primeiro char de str2 em t1
    sb t1, 0(s1) #escrevo em str1

    addi s1, s1, 1 #ando em s1 e s2
    addi s2, s2, 1

    lbu t2, 0(s1)

    bne t2, zero, strcpy

#imprime as duas strings

li a0, 4
la a1, str1
ecall

li a0, 11
li a1, 13
ecall #imprime espaco

li a0, 4
la a1, str2
ecall

li a0, 11
li a1, 13
ecall #imprime espaco

li a0, 10
ecall