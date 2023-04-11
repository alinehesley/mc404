main:
  #addi t0, zero, 1
  #ecall
  #ret
  addi t0, zero, 4   #escolhe a leitura de um inteiro (4)
  ecall
  addi a0, a0, 10
  addi t0, zero, 1   # escolhe a operacao de escrita de inteiro (1)
  ecall              # efetua a operacao de leitura de inteiro
  ret