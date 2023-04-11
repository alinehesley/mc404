main:
  # Le um numero do teclado e armazena em a0
  addi t0, zero, 4
  ecall

  beq a0, zero, fim #se o valor lido for igual a zero vai p fim
  
  # Soma 2 ao valor de a0
  addi a0, a0, 2

  # Imprima o valor de a0 na tela
  addi t0, zero, 1
  ecall

  j main #se for dif de zero

fim:
  ret
