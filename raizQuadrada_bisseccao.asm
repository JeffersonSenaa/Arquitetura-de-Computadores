.data
    entrada: .asciiz "Digite o valor a ser calculado e o valor de Epsilon:\n"
    invalid: .asciiz "Entradas Inválidas\n"
    limit:   .asciiz "Não foi possível calcular sqrt(x)\n"
    msg_result: .asciiz "A raiz quadrada de x eh "
    msg_result_1:  .asciiz ", calculada em "
    msg_result_2:   .asciiz " iteracoes\n"

.text
main:
    input:
    li $v0, 4
    la $a0, entrada     #Impressao da mensagem inicial
    syscall

    li $v0, 5       
    syscall
    move $s0, $v0   #Entrada do valor: x

    li $v0, 5
    syscall         
    move $s1, $v0   #Entrada do valor de Epsilon: Tolerancia

    ble $s0, 1, invalido    #Menor ou Igual a 1         
    blt $s1, 1, invalido    #Menor que 1                
    bgt $s1, 16, invalido   #Maior que 16  

    mtc1 $s1, $f7           #Conversao de Epsilon em float
    cvt.s.w $f7, $f7        
    mtc1 $s0, $f0           #Conversao x em float
    cvt.s.w $f0, $f0

    li.s $f8, 10.0  
    li.s $f10, 1.0

    add $t1, $t1, $zero
    tolerancia:
        mul.s $f10, $f10, $f8   #Multiplicando valor da base em x10
        div.s $f9, $f7, $f10    #Potencia negativa

        addi $t1, $t1, 1
        beq $t1, $s1, iteracao_Inicial
        j tolerancia

    iteracao_Inicial:  
        li.s $f1, 11.0                #Valor inicial de a
        div.s $f2, $f0, $f1         #Resultado b1. b=(x/a)
    
    addi $t0, $t0, 1            #Contador de iteracoes
    iteracao:
        addi $t0, $t0, 1

        #Iteracoes para encontrar a raiz
        add.s $f3, $f1, $f2     #somando a+b
        div.s $f5, $f3, $f1    #Valor de ai = (a + b)/2

        div.s $f6, $f0, $f5     #Valor de bi = x / ai

        mov.s $f1, $f5          #Valor de a-1 para proxima iteracao
        mov.s $f2, $f6          #Valor de b-1 para proxima iteracao

        #Tolerancia
        sub.s $f4, $f5, $f6
        #c.le.s $f4, $f9        #Se a-b <= Tolerancia
        #bc1f saida
        j saida

        beq $t0, 100, limite
    j iteracao

    invalido:
    li $v0, 4
    la $a0, invalid     #Impressão da mensagem de erro
    syscall

    j input

    limite:
        li $v0, 4
        la $v0, limit
        syscall

    saida:
        li $v0, 4
        la $a0, msg_result
        syscall

        li $v0, 2
        mov.s $f12, $f6
        syscall

        li $v0, 4
        la $a0, msg_result_1
        syscall

        li $v0, 1
        move $a0, $t0
        syscall

        li $v0, 4
        la $a0, msg_result_2
        syscall

        li $v0, 10
        syscall

jr $ra