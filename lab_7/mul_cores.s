#pintar a tela em branco
li a0, 0x101
li a1, 0x00FFFFFF
ecall

#desenhar um quadrado deixando dois pontos brancos

#t0 - linha (x)
addi t0, zero, 1
#t1 - coluna (y)
addi t1, zero, 1
#t2 - 7 fim
addi t2, zero, 7

#ponto t5
addi t5, zero, 0


anda_x:
    bge t0, t2, fim #terminei todas as linhas
    #se n terminei, somo mais uma linha
    addi t0, t0, 1
    addi t1, zero, 1
    
anda_y:
    bge t1, t2, anda_x #terminei a coluna, mudo para a prox linha
    addi t1, t1, 1 #incremento coluna
    #t5 - ponto
    #t0 - x
    #t4 - qnt quero deslocar 4 bytes
    slli t5, t0, 16 #desloco p x esq
    or t5, t5, t1 #faco or com y
    li a0, 0x100
    mv a1, t5 #ponto que desejo pintar
    li a2, 0x00FF0000 #registador q incremento
    ecall
    j anda_y

fim:
    addi a0, zero, 10
    ecall   # Encerra a execução do programa
    ret