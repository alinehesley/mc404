#fazer um laço para verificar se tem caracter disponível
#se tiver, lê o caracter e armazena em algum lugar
#posso armazenar em um vetor ou
#em uma string ja alocada


.data
    str: .space 20
.text 

main:

    la s0, str #carrego endereco da string em s0
    #li só funciona c imediato
    mv t0, zero #contador
    li t1, 0x01
    li t2, 0x02
 
    li a0, 0x130 #indica que quero ler uma string do teclado
    ecall

    0:
      li a0, 0x131 #verifica se tem caracter disponivel
      ecall

      beq a0, zero, 2f #tudo lido
      beq a0, t1, 0b #ainda esta lendo
      beq a0, t2, 1f #se n é 0, nem 1 vai ser isso, n precisa dessa linha, leu um caracter

    1:
       #leu o caracter
       sb a1, 0(s0)
       addi s0, s0, 1
       addi t0, t0, 1
       j 0b

    2:
       #final da string 
       sb zero, 0(s0)
    
    #fim
    li a0, 4
    la a1, str
    ecall
    