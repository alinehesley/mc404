main:
   # le um numero do teclado
  addi t0, zero, 4
  ecall 
  
  # subtrai 10 do numero lido 
  addi a0, a0, -10 
  
  #se o num eh menor q zero
  blt a0, zero, negativo
  
  negativo:
   sub a0, zero, a0
   
  #salvando resultado
  add s0, zero, a0
   
  #coloca caractere especial em a0
  addi a0, zero, 45
  
  # imprime o resultado
  addi t0, zero, 2
  ecall

  add a0, zero, s0
  
  addi t0, zero, 1
  ecall 
  
  ret
