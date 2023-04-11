
main:

  #este progrma le um valor a e soma 2000 e 
  #depois subtrai um novo valor b dado pelo
  #usuario e mostra na tela 
  
  #lendo p a0
  addi t0, zero, 4   
  ecall
  
  #somando 2000 em a0           
  addi a0, a0, 2000
  
  #salvando valor de a0 em t1
  add t1, zero, a0
  
  #lendo novo valor para a0
  addi t0, zero, 4
  ecall
  
  #sub t1 - a0
  sub a0, t1, a0
  
  #imprimindo soma
  addi t0, zero, 1
  ecall
  
  #testando operacao logica and
  and a0, sp, t1
  
  #imprimindo operacao and
  addi t0, zero, 1
  ecall
  
  
  
     
  ret
