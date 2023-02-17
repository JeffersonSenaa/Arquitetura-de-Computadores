.data
        invalido: .asciiz "Valor invalido para n."
        mensagem: .asciiz "Insira o valor de n: "
        quebraLinha: .asciiz "\n"
        espaco: .asciiz " "
.text
main:
        li $v0, 4               #imprimir a mensagem inicial 
        la $a0, mensagem
        syscall

        li $v0, 5               #ler o valor de n
        syscall

        move $s0, $v0           #Guardando o valor de n em $s0

        blt $s0, 1, invalid     #Condicao de maior ou igual que. n >=1
        bgt $s0, 100, invalid   #Condicao de menor ou igual a que. n <= 100

    move $s1, $zero          #Criando a variavel i=0.

    laco1:
    slt $t0, $s1, $s0           # i < n --> $t0=1, se não $t0=0.
    beq $t0, $zero, linha       #Condicao de parada do loop. se $t0=0 o loop encerra.

    li $v0, 4
    la $a0, quebraLinha
    syscall

    addi $s1, $s1, 1             #incremento: i = i + 1. Ou i++

    move $s2, $zero          #Inicializando a variave j=0.

        loop:
        slt $t1, $s2, $s1        # j < i --> $t1=1, se não $t1=0.
        beq $t1, $zero, laco1    #Condicao de para do loop que volta para o primeiro laco

        blt  $s1, 10, zero
        bgt  $s1, 9, semzero
        zero:
            move $s6, $zero
            li $v0, 1
            move $a0, $s6
            syscall
            
        semzero:
        li $v0, 1               #Imprimindo a piramide. Variavel i.
        move $a0, $s1
        syscall

        li $v0, 4
        la $a0, espaco
        syscall

        addi $s2, $s2, 1         #incremento: j = j + 1. Ou j++
        j loop

    linha:
        li $v0, 4
        la $a0, quebraLinha
        syscall

    move $s4, $zero

    laco2:
    slt $t2, $s4, $s0   # i < n --> $t0=1, se não $t0=0.
    beq $t2, $zero, saida

    li $v0, 4 
    la $a0, quebraLinha
    syscall

    addi $s4, $s4, 1

    move $s5, $zero

        loop2:
            slt $t3, $s5, $s4
            beq $t3, $zero, laco2
            addi $s5, $s5, 1

            blt  $s5, 10, zeros
            bgt  $s5, 9, semZero

            zeros:
            move $s6, $zero
            li $v0, 1
            move $a0, $s6
            syscall
            
        semZero:
            li $v0, 1
            move $a0, $s5
            syscall

            li $v0, 4 
            la $a0, espaco
            syscall

            j loop2

saida:
    li $v0, 10
    syscall


invalid:
    li $v0, 4
    la $a0, invalido
    syscall

    li $v0, 10
    syscall