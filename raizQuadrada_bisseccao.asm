.data
    entrada: .asciiz "Digite o valor a ser calculado e o valor de Epsilon:\n"
    invalid: .asciiz "Entradas Inválidas\n"

.text
main:
    li $v0, 4
    la $a0, entrada     #Impressão da mensagem inicial
    syscall

    li $v0, 5       #Entrada do valor 
    syscall
    move $t0, $v0   #Valor a ser calculado

    li $v0, 5
    syscall         #Entrada do valor de Epsilon
    move $t1, $v0   #Valor de Epsilon

    ble $t0, 1, invalido    #Menor ou Igual a 1
    blt $t1, 1, invalido    #Menor que 1
    bgt $t1, 16, invalido   #Maior que 16

    j exit

    invalido:
    li $v0, 4
    la $a0, invalid     #Impressão da mensagem de erro
    syscall

    j main

    exit:
        li $v0, 10
        syscall

jr $ra