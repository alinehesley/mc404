main:
  #le primeiro num em a0
  addi t0, zero, 4
  ecall

  beq a0, zero, fim
  
  #guarda primeiro num
  add s0, zero, a0
  
  #le segundo num, esta em a0
  addi t0, zero, 4
  ecall
  
  beq a0, zero, fim

  # s0 menor a0
  blt s0, a0, imprime
  
  #s0 maior a0
  add a0, zero, s0
  jal imprime
 
imprime:
  addi t0, zero, 1
  ecall
  
j main

fim:
   ret

