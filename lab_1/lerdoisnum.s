main:
  #ler primeiro num e salva em t1
  addi t0, zero, 4
  ecall
  add t1, zero, a0

  #ler segundo num, provavelmente vai alterar o valor a0
  addi t0, zero, 4
  ecall 

  add a0, a0, t1

  addi t0, zero, 1
  ecall
  
  ret