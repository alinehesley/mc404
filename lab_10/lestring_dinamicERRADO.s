.data 
    buffer: .space 256
.text

main:
    la a0, buffer #carrega buffer em a0

    call LeString #recebe a0 como parâmetro

    #a str está no buffer
    #agr preciso copiar a string lida no LeString (buffer) para o novo endereço de memoria 
    #com espaço adequado (agr preciso ver como armazenar espaço adequado)

    #recebe no a1 o espaço ideal (num), ja recebeu na LeString
    #chamada de sistema para alocar memória:
    #ja esta em a1 a qnt de caracteres
    li a0, 9 #chamada de sistema p alocar dinamicamente
    ecall
    
    #devolve em a0 o espaço alocado
    la a1, buffer
    call Strcpy #recebe a0 e a1

    mv a1, a0
    call imprimeString

    #Encerra o programa 
    li a0, 10  
    ecall

LeString:
    addi sp, sp, -12
    sw s1, 8(sp)
    sw s0, 4(sp)
    sw ra, 0(sp)

    mv t0, zero

    mv s0, a0 #carregando str em s0
     
    li s1, 0x01

    li a0, 0x130
    ecall

    loop_leitura:
        li a0, 0x131
        ecall

        beq a0, zero, tudo_lido
        beq a0, s1, loop_leitura
        #lendo caracter
        sb a1, 0(s0)
        addi s0, s0, 1
        addi t0, t0, 1
        j loop_leitura
    
    tudo_lido:
        sb zero, 0(s0) #add \0 no final da string
        addi t0, t0, 1
        
        
    fim:
    la a0, buffer 
    mv a1, t0

    lw ra, 0(sp) #carrega o valor de ra da main
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12
    ret

imprimeString:
    li a0, 4
    #la a1, str1 ja movi
    ecall
    ret

Strcpy: #recebe como paramentro a0 (t3) e a1 (t4)
#quero copiar do buffer para o espaço q foi alocado dinamicamente
#char * strcpy(char *t3, char *t4)
#copia o conteúdo da t4 para t3

    mv t3, a0 #str1
    mv t4, a1 #str2

    lbu t1, 0(t4) #leio primeiro char de str2 em t1

    sb t1, 0(t3) #escrevo em char de str2 em str1

    addi t3, t3, 1 #ando em t3 e t4
    addi t4, t4, 1

    lbu t2, 0(t4) #leio o caracter de str1

    bne t2, zero, Strcpy 

    sb zero, 0(t3)
    mv a0, t3
    ret