.data
    invalid: .asciiz "Entradas Inválidas\n"
    limit:   .asciiz "Não foi possível calcular sqrt(x)\n"
    msgResult: .asciiz "Raiz quadrada eh  "
    msgResult1: .asciiz " eh "
    msgResult2:  .asciiz ", calculada em "
    msgResult3:   .asciiz " iteracoes\n"

.text
.globl main
main:
        li $v0, 5       
        syscall
        move $s0, $v0   #Entrada do valor: x

        li $v0, 5
        syscall         
        move $s1, $v0   #Entrada do valor de Epsilon: Tolerancia

        ble $s0, 1, invalido    #Menor ou Igual a 1         
        blt $s1, 1, invalido    #Menor que 1                
        bgt $s1, 16, invalido   #Maior que 16  

        mtc1.d $s1, $f16           #Conversao de Epsilon em float
        cvt.d.w $f16, $f16        
        mtc1.d $s0, $f0           #Conversao x em float
        cvt.d.w $f0, $f0

        li.d $f8, 10.0  
        li.d $f10, 1.0

        li $t1, 0
    tolerancia:
        mul.d $f10, $f10, $f8   #Multiplicando valor da base em x10
        div.d $f14, $f16, $f10    #Potencia negativa

        addi $t1, $t1, 1
        bgt $t1, $s1, iteracao_Inicial
        j tolerancia

    iteracao_Inicial:  
        li.d $f22, 11.0                #Valor inicial de a1
        div.d $f2, $f0, $f22         #Resultado b1. b=(x/a)
    
        li.d $f24, 2.0
        li $t0, 1            #Contador de iteracoes
    iteracao:
        addi $t0, $t0, 1

        #Iteracoes para encontrar a raiz
        add.d $f20, $f22, $f2     #somando a1+b1
        div.d $f18, $f20, $f24    #Valor de ai = (a + b)/2

        div.d $f6, $f0, $f18     #Valor de bi = x / ai

        mov.d $f22, $f18          #Valor de a-1 para proxima iteracao
        mov.d $f2, $f6          #Valor de b-1 para proxima iteracao

        #Tolerancia
        jal epsilon
        
        beq $t0, 100, limite
        
    j iteracao

    invalido:
        li $v0, 4
        la $a0, invalid     #Impressão da mensagem de erro
        syscall

        li $v0, 10
        syscall

    limite:
        li $v0, 4
        la $a0, limit
        syscall

        li $v0, 10
        syscall

    epsilon:
        c.lt.d $f18, $f6
        bc1t troca
        sub.d $f4, $f18, $f6
        c.le.d $f4, $f14        #Se a-b <= Tolerancia
        bc1t saida

    retorno:    
        jr $ra    

    troca:
        sub.d $f4, $f6, $f18
        c.le.d $f4, $f14        #Se a-b <= Tolerancia
        bc1t saida
        j retorno

    saida:
        li $v0, 4
        la $a0, msgResult
        syscall

        li $v0, 1
        move $a0, $s0
        syscall

        li $v0, 4
        la $a0, msgResult1
        syscall

        li $v0, 3
        mov.d $f12, $f18
        syscall

        li $v0, 4
        la $a0, msgResult2
        syscall

        li $v0, 1
        move $a0, $t0
        syscall

        li $v0, 4
        la $a0, msgResult3
        syscall

        li $v0, 10
        syscall