li a0, 0x100 #carrega no a0 0x100 que jnt c o ecall escreve um pont na tela
li a1, 0x00000002 #x
li a2, 0xdd0b64 #y
ecall

#como sei como 
#calcular o ponro da matriz?


# li a0, 0x101
# li a1, 0xdd0b64
# ecall