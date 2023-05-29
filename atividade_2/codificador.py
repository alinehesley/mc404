import sys

#dict do opcode
op = {'addi': '0010011', 'slli':'0010011', 'xor':'0110011', 'call':'1101111', 'ret':'1100111', 'beq':'1100011', 'lw':'0000011', 'sw':'0100011', 'mul':'0110011', 'lui':'0110111'}

#dict dos registradores
registrador = {'zero': '0', 'ra': '1', 'sp':'2','gp': '3', 'tp': '4', 't0':'5', 't1':'6', 't2': '7', 's0':'8', 'fp':'8', 's1':'9'}

for i in range(0, 8):
    registrador['a'+ str(i)] = str(i + 10)

for i in range(2, 12):
    registrador['s'+ str(i)] = str(16+i)

for i in range(3, 7):
    registrador['t'+ str(i)] = str(25+i)


#converte uma str em decimal para binário e
#retorna no intervalo [l, r] 

def strdec_bin(s,l,r):
    #int(s) >= 0
    binario = bin(int(s))[2:] # 0b00000101

    if int(s) < 0:
        binario = bin((int(s) + (1 << 32)) % (1 << 32))[2:]

    binario = binario.zfill(32)[(31-r) : (31-l+1)]
    
    return binario

def bits_hex(bits):
    n = int(bits, 2)
    hexadecimal = hex(n)[2:].zfill(8)
    return '0x' + hexadecimal.upper()


def separa(str):
    valor = str.replace('(', ' ').replace(')', ' ').split(' ')
    r = valor[1]
    imm = valor[0]
    return r, imm

#coloca em binário o valor de cada um dos registradores
for [chave,val] in registrador.items():
    registrador[chave] = strdec_bin(val,0,4)

def codifica_addi(valores):
    #imm[11:0] rs1 000 rd 0010011
    p1 = op[valores[0]]
    p2 = registrador[valores[1]]
    p3 = '000'
    p4 = registrador[valores[2]]
    p5 = strdec_bin(valores[3] ,0 , 11)
    print(bits_hex(p5 + p4 + p3 + p2 + p1))

def codifica_slli(valores):
    #0000000 shamt(imm[4:0]) rs1 001 rd 0010011
    p1 = op[valores[0]]
    p2 = registrador[valores[1]]
    p3 = '001'
    p4 = registrador[valores[2]]
    p5 = strdec_bin(valores[3], 0, 4)
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
    # call 0x7873
    p1 = op[valores[0]]
    p2 = registrador['ra'] #aqui é o ra
    rot = int(valores[1]) - 1000
    p3 = strdec_bin(rot, 20, 20) + strdec_bin(rot, 1, 10) + strdec_bin(rot, 11, 11) + strdec_bin(rot, 12, 19)
    print(bits_hex(p3 + p2 + p1))

def codifica_ret(valores): #o valor é cte
    #(JALR zero, ra, 0) -  imm[11:0] rs1 000 rd 1100111
    #(JALR rd, rs1, imm)
    p1 = op[valores[0]]
    p2 = '00000'#zero
    p3 = '000'
    p4 = registrador['ra']
    p5 = '0000000000'
    print(bits_hex(p5 + p4 + p3 + p2 + p1))

def codifica_beq(valores): 
    #beq - imm[12|10:5] rs2 rs1 000 imm[4:1|11] 1100011
    p1 = op[valores[0]]
    rot = int(valores[3]) - 1000 #vai me dar p onde saltar
    p2 = strdec_bin(rot, 1, 4) + strdec_bin(rot,11,11)
    p3 = '000'
    p4 = registrador[valores[1]]
    p5 = registrador[valores[2]]
    p6 = strdec_bin(rot, 12, 12) + strdec_bin(rot, 5, 10)
    print(bits_hex(p6 + p5 + p4 + p3 + p2 + p1))

def codifica_lw(valores):
    #lw - imm[11:0] rs1 010 rd 0000011
    p1 = op[valores[0]]
    p2 = registrador[valores[1]]
    p3 = '010'
    r, imm = separa(valores[2])
    p4 = registrador[r]
    p5 = strdec_bin(imm, 0, 11)
    print(bits_hex(p5 + p4 + p3 + p2 + p1))

def codifica_sw(valores):
    #sw - imm[11:5] rs2 rs1 010 imm[4:0] 0100011 
    p1 = op[valores[0]]
    r, imm = separa(valores[2])
    p2 = strdec_bin(imm, 0, 4)
    p3 = '010'
    p4 = registrador[r]
    p5 = registrador[valores[1]]
    p6 = strdec_bin(imm, 5, 11)
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

def codifica_lui(valores):
    #imm[31:12] rd 0110111, na realidade imm[20:0]
    p1 = op[valores[0]]
    p2 = registrador[valores[1]] 
    p3 = strdec_bin(valores[2], 0, 20)
    print(bits_hex(p3 + p2 + p1))


def codifica_li(valores):
    #li x2, 0xFFFFFFFF
    N = int(valores[2])
  
    if(N >= -2048 and N <= 2047): #só joga o valor no addi
        valores_addi = ['addi', valores[1], 'zero', valores[2]]
        codifica_addi(valores_addi)

    else:
        #estender sinal baixo 12 bits
        M = N & 0b00000000000000000000111111111111

        bit_12 = (N >> 11) & 1
        K = N & 0b11111111111111111111000000000000
        if(bit_12 == 1):
            K += 4096 #incrementa 
        K = K >> 12 #pq minha funcao pega do [20:0]

        # Load upper 20 bits
        valores_lui = ['lui', valores[1], K]
        codifica_lui(valores_lui)
        #LUI x2,K

        # Add lower bits
        valores_addi = ['addi', valores[1], valores[1], M]
        codifica_addi(valores_addi)
        #ADDI x2,x2,M

try:
    while True:
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
            elif opcode == 'li':
                codifica_li(valores)
            else:
                print("Instrução não reconhecida/disponível")
except EOFError:
    sys.exit(0)

