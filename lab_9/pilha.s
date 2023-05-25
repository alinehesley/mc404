#O que salvar:
# Registradores s, ra, a, variaveis locais q
# preciso alocar na memoria

funcao: addi sp, sp, -52
        sw   s1, 48(sp)
        sw   s0, 44(sp)
        sw   ra, 40(sp)
        mv   s0, sp      # s0 aponta para o início do vetor
        #sp ta apontando p a utima posicao alocada
        #desceu 52
        #ent movo a referencia do sp para s0,
        #la comeca meu vetor e vai subindo

#ALOCANDO DOIS VETORES
funcao: addi sp, sp, -52
        sw   s1, 48(sp)
        sw   s0, 44(sp)
        sw   ra, 40(sp)
        mv   s0, sp      # s0 aponta para o início do vetor de 6 inteiros
        addi s1, sp, 24  # s1 aponta para o início do vetor de 4 inteiros
