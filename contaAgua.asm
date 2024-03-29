.data 
    msg: .asciiz "Digite o valor de N: "
    invalido: .asciiz "Valor invalido para N."
    quebraLinha: .asciiz "\n"
    
.text
main:
    li $v0, 4           
    la $a0, msg
    syscall

    li $v0, 5       #Valor de n
    syscall

    move $s0, $v0   #Guardando o valor de n em $s0

    blt $s0, 0, invalid         #Condicao menor que para valor de n
    bgt $s0, 1000, invalid      #Condicao maior que para valor de n

    bgt $s0, 100, valor1        # n > 100

    bgt $s0, 30, valor2         # n > 30

    bgt $s0, 10, valor3         # n > 10

    blt $s0, 11, valor4        # n < 11

    addi $s0, $zero, 7

    valor1:
        addi $s2, $zero, 100    #$s2=100
        addi $s3, $zero, 5      #$s3=5
        sub $s4, $s0, $s2
        mul $s5, $s3, $s4       #valor da multiplicação n x 5

        addi $t2, $zero, 7          #Valor fixo 7

        addi $t0, $zero, 140    
        addi $t1, $zero, 20

        add $s6, $s5, $t0
        add $s7, $s6, $t1
        add $s1, $s7, $t2

        li $v0, 1
        move $a0, $s1
        syscall

        li $v0, 10
        syscall
        
    valor2:
        addi $s2, $zero, 30      #$s2=30
        addi $s3, $zero, 2      #$s3=2
        sub $s4, $s0, $s2
        mul $s5, $s3, $s4       #valor da multiplicação n x 2

        addi $t2, $zero, 7          #Valor fixo 7   
        addi $t1, $zero, 20

        add $s6, $s5, $t1
        add $s7, $s6, $t2

        li $v0, 1
        move $a0, $s7
        syscall

        li $v0, 10
        syscall

    valor3:
        addi $s2, $zero, 10      #$s2=11
        sub $s3, $s0, $s2        # n-11

        addi $t2, $zero, 7          #Valor fixo 7  

        add $s4, $s3, $t2

        li $v0, 1
        move $a0, $s4
        syscall

        li $v0, 10
        syscall

    valor4:
        addi $s0, $zero, 7

        li $v0, 1
        move $a0, $s0
        syscall

        li $v0, 10
        syscall


    invalid:
        li $v0, 4
        la $a0, invalido
        syscall

        li $v0, 4
        la $a0, quebraLinha
        syscall

        j main