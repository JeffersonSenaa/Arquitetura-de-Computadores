.data
     valor1: .asciiz "Digite o primeiro valor ---------------: "
     valor2: .asciiz "================Digite o segundo valor: "
     resultado: .asciiz "O resultado é "

.text
main: 

     li $v0, 4  #Imprime a string
     la $a0, valor1
     syscall

     li $v0, 5  #Entrada de dados
     syscall

     move $s0, $v0  #O valor inserido está em $s0

     li $v0, 4 
     la $a0, valor2
     syscall

     li $v0, 5 #Entrada do próximo número
     syscall

     move $s1, $v0  #O segundo valor está em $s1

     add $t0, $s0, $s1  #Soma os valores inseridos

     li $v0, 4 
     la $a0, resultado
     syscall

     li $v0, 1    #Imprimir inteiro
     move $a0, $t0  #Imprimir valor de $t0
     syscall

     li $v0, 10
     syscall