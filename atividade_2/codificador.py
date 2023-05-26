#dict do opcode
op = {'addi': '0010011', 'slli':'0010011', 'xor':'0110011', 'call':'1101111', 'ret':'1100111', 'beq':'1100011', 'lw':'0000011', 'sw':'0100011', 'mul':'0110011'}

#dict dos registradores
registrador = {'zero': '0', 'ra': '1', 'sp':'2','gp': '3', 'tp': '4', 't0':'5', 't1':'6', 't2': '7', 's0':'8', 'fp':'8', 's1':'9'}

for i in range(0, 8):
    registrador['a'+ str(i)] = str(i + 10)

for i in range(2, 12):
    registrador['s'+ str(i)] = str(16+i)

for i in range(3, 7):
    registrador['t'+ str(i)] = str(25+i)

def str_bin(s,l,r):
    # 0b00000101
    binario = bin(int(s))[2:]

    if int(s) < 0:
        #binario = bin(~(-int(s)))[2:]
        binario = bin((int(s) + (1 << 32)) % (1 << 32))[2:]

    binario = binario.zfill(32)[(31-r) : (31-l+1)]
    
    return binario

# def str_bin(s,l,r):
#     # 0b00000101
#     binario = bin(int(s))[2:]

#     if int(s) < 0:
#         binario = bin(~(-int(s)))[2:]

#     #binario = bin(int(s))[2:].zfill(32)[(31-r) : (31-l+1)]
#     binario = binario.zfill(32)[(31-r) : (31-l+1)]
    
#     return binario

# def str_bin_signed(s,l,r):
#     # 0b00000101
#     binario = bin(int(s))[2:].zfill(32)[(31-r) : (31-l+1)]
#     return binario

def bits_hex(bits):
    n = int(bits, 2)
    hexadecimal = hex(n)[2:].zfill(8)
    return '0x' + hexadecimal

def separa(str):
    valor = str.replace('(', ' ').replace(')', ' ').split(' ')
    r = valor[1]
    imm = valor[0]
    return r, imm

#coloca em binário o valor de cada um dos registradores
for [chave,val] in registrador.items():
    registrador[chave] = str_bin(val,0,4)

def codifica_addi(valores):
    #imm[11:0] rs1 000 rd 0010011
    p1 = op[valores[0]]
    p2 = registrador[valores[1]]
    p3 = '000'
    p4 = registrador[valores[2]]
    p5 = str_bin(valores[3],0 , 11)
    print(bits_hex(p5 + p4 + p3 + p2 + p1))

def codifica_slli(valores):
    #0000000 shamt(imm[4:0]) rs1 001 rd 0010011
    p1 = op[valores[0]]
    p2 = registrador[valores[1]]
    p3 = '001'
    p4 = registrador[valores[2]]
    p5 = str_bin(valores[3], 0, 4)
    p6 = '0000000'
    print(bits_hex(p6 + p5 + p4 + p3 + p2 + p1))

def codifica_xor(valores):
    #0000000 rs2 rs1 100 rd 0110011 
    p1 = op[valores[0]]
    p2 = registrador[valores[1]]
    p3 = '100'
    p4 = registrador[valores[2]]
    p5 = registrador[valores[3]]
    p6 = '0000000'
    print(bits_hex(p6 + p5 + p4 + p3 + p2 + p1))

def codifica_call(valores):
    # (JAL ra, destino) - imm[20|10:1|11|19:12] rd 1101111
    # JAL rd, rot
    #call 0x7873
    p1 = op[valores[0]]
    p2 = registrador['ra'] #aqui é o ra
    rot = int(valores[1]) - 1000
    p3 = str_bin(rot, 20, 20) + str_bin(rot, 1, 10) + str_bin(rot, 11, 11) + str_bin(rot, 12, 19)
    print(bits_hex(p3 + p2 + p1))

def codifica_ret(valores):
    #(JALR zero, ra, 0) -  imm[11:0] rs1 000 rd 1100111
    #(JALR rd, rs1, imm)
    p1 = op[valores[0]]
    p2 = '00000'#zero
    p3 = '000'
    #eh o ra, rs1. Qual eh o ra??
    p4 = registrador['ra']
    p5 = '0000000000'
    print(bits_hex(p5 + p4 + p3 + p2 + p1))

def codifica_beq(valores): 
    #beq - imm[12|10:5] rs2 rs1 000 imm[4:1|11] 1100011
    p1 = op[valores[0]]
    rot = int(valores[3]) - 1000 #vai me dar p onde saltar, dá ruim p qnd salto é negativo

    print("opa, preciso saltar", rot, " posicoes")
    print("num em bin:", str_bin(str(rot), 0, 12))

    p2 = str_bin(str(rot), 1, 4) + str_bin(str(rot),11,11)
    print ("a p2: ", p2)

    p3 = '000'

    p4 = registrador[valores[1]]
    p5 = registrador[valores[2]]

    p6 = str_bin(str(rot), 12, 12) + str_bin(str(rot), 5, 10)
    print("a p6: ", p6)

    print(bits_hex(p6 + p5 + p4 + p3 + p2 + p1))

def codifica_lw(valores):
    #lw - imm[11:0] rs1 010 rd 0000011
    p1 = op[valores[0]]
    p2 = registrador[valores[1]]
    p3 = '010'
    r, imm = separa(valores[2])
    p4 = registrador[r]
    p5 = str_bin(imm, 0, 11)
    print(bits_hex(p5 + p4 + p3 + p2 + p1))

def codifica_sw(valores):
    #sw - imm[11:5] rs2 rs1 010 imm[4:0] 0100011 
    p1 = op[valores[0]]
    r, imm = separa(valores[2])
    p2 = str_bin(imm, 0, 4)
    p3 = '010'
    p4 = registrador[r]
    p5 = registrador[valores[1]]
    p6 = str_bin(imm, 5, 11)
    print(bits_hex(p6 + p5 + p4 + p3 + p2 + p1))

def codifica_mul(valores):
    #0000001 rs2 rs1 000 rd 0110011 
    p1 = op[valores[0]]
    p2 = registrador[valores[1]]
    p3 = '000'
    p4 = registrador[valores[2]]
    p5 = registrador[valores[3]]
    p6 = '0000001'
    print(bits_hex(p6 + p5 + p4 + p3 + p2 + p1))

def codifica_lui():
    return print('ainda n')

instrucao = input()
valores = instrucao.replace(",","").split(" ")

#Recebo valores
#verifico qual o opcode, dependendo do opcode vai p uma funcao q codifica ele

opcode = valores[0]

if opcode == 'addi':
    codifica_addi(valores)
elif opcode == 'slli':
    codifica_slli(valores)
elif opcode == 'xor':
    codifica_xor(valores)
elif opcode == 'call':
    codifica_call(valores)
elif opcode == 'ret':
    codifica_ret(valores)
elif opcode == 'beq':
    codifica_beq(valores)
elif opcode == 'lw':
    codifica_lw(valores)
elif opcode == 'sw':
    codifica_sw(valores)
elif opcode == 'mul':
    codifica_mul(valores)
elif opcode == 'lui':
    codifica_lui(valores)
else:
    print("Instrução não reconhecida/disponível")
