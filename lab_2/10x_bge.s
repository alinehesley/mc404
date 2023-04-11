main:
  addi s0, zero, 9 #nove pq executa a primeira vez sem contar
  addi s1, s1, 1

  # Le um numero do teclado e armazena em a0
  addi t0, zero, 4
  ecall
  
  # Soma 2 ao valor de a0
  addi a0, a0, 2

  # Imprima o valor de a0 na tela
  addi t0, zero, 1
  ecall
  
  #BGE rs1, rs2, label - salta se rs1 for maior ou igual a rs2 
 
  bge s0, s1, main
  ret
