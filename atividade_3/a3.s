.data

vetor: 

  .word 0b00111111, 0b00000110, 0b01011011, 0b01001111, 0b01100110, 0b01101101, 0b01111101, 0b00000111, 0b01111111, 0b01101111

.text 

main:

call lebotao
mv s11, a0

call acende_led

li s10, 0

loop:
    mv a0, s11
    mv a1, s10
    call contagem
    mv s10, a0 # recupera valor da contagem

    mv a0, s10
    call imprime

    li a0, 500
    call pausa

    j loop
    
lebotao:
    li a0, 0x122
    ecall
    ret

acende_led:
  mv t0, a0
  li a0, 0x121
  xori t0, t0, 0b11
  # se apertar 0 botoes acende os dois
  # se apertar os dois botoes nao acende nada
  mv a1, t0
  ecall
  ret

#recebe o botao (a0) e valor atual (a1)
contagem:
  addi sp,sp,-20
  sw s0,0(sp)
  sw s1,4(sp)
  sw s2,8(sp)
  sw ra,12(sp)

  mv s1, a1 #contador - 0
  li s0, 2
  li s2, 99
  #se for igual o a0 a 1 é p fazer contagem crescente 
  beq a0, s0,  crescente
  #quando o chegar a 99 mudar para 00
  decrescente:
   addi s1, s1, -1
   li t0,-1
   bne s1, t0, final_contagem
   li s1, 99 # se for -1 vira 99
  
  j final_contagem

  crescente:
  #se for igual a 0 faz descrescente 
  #quando chegar a 00 ir para 99
  addi s1, s1, 1
  li t0,100
  bne s1, t0, final_contagem
  li s1, 0 # se 100 vira 00
  
  final_contagem:
  mv a0, s1
  lw s0,0(sp)
  lw s1,4(sp)
  lw s2,8(sp)
  lw ra,12(sp)
  addi sp,sp,20
  ret

# recebe numero de execs em a0
pausa:
    loop_pausa:
    addi a0, a0, -1
    bge a0, zero, loop_pausa
    ret

# recebe em a0 o valor
imprime:
  addi sp,sp,-16
  sw s0,0(sp)
  sw s1,4(sp)
  sw ra,8(sp)
 
  li t0,0

  # dezena
  li t2,10
  div t1,a0,t2
  rem t1,t1,t2

  # coloca vetor[t1]<<8 em t0
  la t2, vetor
  
  # pega a posicao
  li t3,4
  mul t1,t1,t3
  add t2,t2,t1
  #  
  lw t2, 0(t2)
  slli t2,t2,8
  
  add t0,t0,t2 

  # unidade
  li t2,10
  rem t1,a0,t2

  # coloca vetor[t1] em t0
  la t2, vetor
  
  # pega a posicao
  li t3,4
  mul t1,t1,t3
  add t2,t2,t1
  #  
  lw t2, 0(t2)
  
  add t0,t0,t2 
 
  li a0,0x120
  mv a1, t0
  li a2, 0b1111111111111111
  ecall

  lw s0,0(sp)
  lw s1,4(sp)
  lw ra,8(sp)
  addi sp,sp,16
  ret