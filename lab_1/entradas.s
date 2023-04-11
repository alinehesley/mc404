main:
  addi t0, zero, 4   # escolhe a operacao de leitura de inteiro (4)
  ecall              # efetua a operacao de leitura de inteiro
  addi a0, a0, 2
  ret