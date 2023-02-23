.data
    temp1: .space 10
    temp2: .space 10
    valor: .float 0.00
    kel: .float 273.15
    c: .asciiz "C"
    k: .asciiz "K"
    f: .asciiz "F"
    
.text
main:
    li $v0, 8
    la $a0, temp1
    la $a1, 10
    syscall
    la $s0, temp1   #Escala de entrada

    li $v0, 8
    la $a0, temp2
    la $a1, 10
    syscall
    la $s1, temp2   #Escala de saida

    li $v0, 6
    syscall
    mov.s $f0, $f0
    s.s $f0, valor

    la $s2, c
    la $s3, k
    la $s4, f

    lb $t0, ($s0)   #Entrada 1 
    lb $t1, ($s1)   #Entrada 2
    lb $t2, ($s2)   #celsius
    lb $t3, ($s3)   #kelvin
    lb $t4, ($s4)   #farenheit

    beq $t0, $t1, iguais     #Se as escalas forem iguais
    beq $t0, $t2, celsius    #Se a entrada for celsius
    beq $t0, $t3, kelvin     #Se a entrada for kelvin
    beq $t0, $t4, farenheit

    j saida

    iguais:
        l.s $f12, valor
        li $v0, 2
        syscall

        j saida

    celsius:
        beq $t1, $t3, c_k
        beq $t1, $t4, c_f
        j saida

        c_k:
            #Conversao de celsius para kelvin
            l.s $f4, kel    #Ainda não esta imprimindo completo
            add.s $f2, $f0, $f4

            li $v0, 2
            mov.s $f12, $f2
            syscall

            j saida

        c_f:
            #Conversao de celsius para farenheit
            li.s $f4, 1.8
            li.s $f6, 32.0

            mul.s $f2, $f0, $f4 #calculo da conversao 
            add.s $f2, $f2, $f6

            li $v0, 2
            mov.s $f12, $f2
            syscall

            j saida

    kelvin:
        beq $t1, $t2, k_c
        beq $t1, $t4, k_f

        k_c:
            #Conversao de kelvin para celsius
            li.s $f4, 273.15

            sub.s $f2, $f0, $f4 #calculo da conversao 

            li $v0, 2
            mov.s $f12, $f2
            syscall

            j saida

        k_f:
            #kelvin para farenheit
            li.s $f4, 1.8
            li.s $f6, 459.67

            mul.s $f2, $f0, $f4 #calculo da conversao 
            sub.s $f2, $f2, $f6 

            li $v0, 2
            mov.s $f12, $f2
            syscall

            j saida
            

    farenheit:
        beq $t1, $t2, f_c
        beq $t1, $t3, f_k

        f_c:
            #farenheit para celsius
            li.s $f4, 1.8
            li.s $f6, 32.0

            sub.s $f2, $f0, $f6 #calculo da conversao 
            div.s $f2, $f2, $f4

            li $v0, 2
            mov.s $f12, $f2
            syscall

            j saida

        f_k:
            #farenheit para kelvin
            li.s $f4, 1.8
            li.s $f6, 459.67

            add.s $f2, $f0, $f6 #calculo da conversao 
            div.s $f2, $f2, $f4 

            li $v0, 2
            mov.s $f12, $f2
            syscall

            j saida
            
    saida:
        li $v0, 10
        syscall