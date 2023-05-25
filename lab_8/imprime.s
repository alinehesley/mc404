.data

  str1: .string "Teste de string"
  str2: .space 20
  str3: .string "Hello World"

.text
main:
  li a0, 4
  la a1, str1
  ecall          # Imprime string str1

  li a0, 11
  li a1, 13
  ecall          # Imprime caracter de nova linha (\n)

  la s0, str2 #s0 recebe str2 (espaço p 20)
  li s1, 20 #tamanho da string?
  li s3, 65 #codigo da string A
loop: 

  #escreve AAAAAAAAA 20x kkk

  sb s3, 0(s0) #escrevo s3 na primeira posição de s0
  addi s0, s0, 1 #ando 1 em s0
  addi s1, s1, -1 #diminuo o contador
  bne  s1, zero, loop #se o contador for diferente zero, aí byeee

  li a0, 4      
  la a1, str2
  ecall          # Imprime string str2: AAAAAAAA....

  li a0, 11
  li a1, 13
  ecall          # Imprime caracter de nova linha (\n)

  li a0, 4
  la a1, str2
  sb zero, 19(a1) #escrevo 0 na última posição da string, ent antes imprimiu str2 e str3
  #pq ele n sabia qual o final de str2 :( OMG
  ecall          # Imprime string str2: AAAAAAAAAAAAAAAAAAA

  li a0, 11
  li a1, 13
  ecall          # Imprime caracter de nova linha (\n)

  li a0, 4
  la a1, str3
  ecall          # Imprime string str3

  li a0, 11
  li a1, 13
  ecall          # Imprime caracter de nova linha (\n)

  li a0, 10
  ecall          # Encerra o programa
  ret
