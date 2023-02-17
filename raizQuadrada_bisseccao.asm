.data
    entrada: .asciiz "Digite o valor a ser calculado e o valor de Epsilon:\n"
    invalid: .asciiz "Entradas Inválidas\n"
    limit:   .asciiz "Não foi possível calcular sqrt(x)\n"
    
    format:  .asciiz "%.16lf\n"

.text
main:
    input:
    li $v0, 4
    la $a0, entrada     #Impressao da mensagem inicial
    syscall

    li $v0, 5       #Entrada do valor: x
    syscall
    move $s0, $v0   #Valor a ser calculado

    li $v0, 5
    syscall         #Entrada do valor de Epsilon
    move $s1, $v0   #Valor de Epsilon: Tolerancia

    ble $s0, 1, invalido    #Menor ou Igual a 1         #$s0 guarda x
    blt $s1, 1, invalido    #Menor que 1                #$s1 guarda E
    bgt $s1, 16, invalido   #Maior que 16               

    iteracao1:                                               
    addi $t2, $zero, 2       #Valor de a

    mtc1 $s0, $f0           #Converte x para ponto flutuante
    mtc1 $t2, $f1

    div.s $f2, $f0, $f1     #Resultado de b armazenado em $f2. Divisao em ponto flutuante
    li.s $f4, 2.0

    move $t0, $zero         #inicializando i
    iteracao:
        add.s $f3, $f1, $f2     #somando a+b
        div.s $f5, $f3, $f4     #Valor de ai = (a + b)/2

        div.s $f6, $f0, $f5     #Valor de bi = x / ai

        addi $t0, $t0, 1
        beq $s0, 100, limite
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

    exit:
        li $v0, 2
        mov.s $f12, $f2
        syscall

        li $v0, 10
        syscall

jr $ra