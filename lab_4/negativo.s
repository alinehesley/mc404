main:
  # le um numero do teclado
  addi t0, zero, 4
  ecall    

  # subtrai 10 do numero lido 
  addi a0, a0, -10 

  #se for menor que zero ai subtraio e coloco um -
  bge a0, zero, num_positivo #se a0 eh maior zero
  

  num_negativo: #guarda em s1
    sub s1, zero, a0
    #imprime - 
    addi a0, zero, 45
    addi t0, zero, 2
    ecall

    #coloca no a0 o que esta em s1
    add a0, zero, s1 

  num_positivo:
    # imprime o resultado
    addi t0, zero, 1
    ecall 
    ret

