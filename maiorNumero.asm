.data
    msg:  .asciiz "Digite a quantidade n de numeros: "
    comparacao: .asciiz "Digite um numero: "
    comparar: .asciiz "Digite outro valor: "
    invalido: .asciiz "Valor invalido para n"

.text
main:
    li $v0, 4       #Impressão da mensagem 
    la $a0, msg
    syscall

    li $v0, 5       #Ler o numero inteiro
    syscall

    move $s0, $v0   #Guardando o valor da quantidade de repeticoes em $s0

    addi $t1, $zero,1

    blt $s0, 1, invalid         #Condicao para n
    bgt $s0, 100000, invalid

    li $v0, 4       #chamada para o primeiro valor
    la $a0, comparacao
    syscall

    li $v0, 5       #Primeiro valor da comparacao
    syscall

    move $s1, $v0   #Guardando o primeiro valor em $s1

    addi $s3, $zero,1 #Cria o contador do laco (i=0)
    laco:

    slt $t0, $s3, $s0   #se $s3 < $s0 então $t0 recebe 1, caso contrario recebe 0.
    beq $t0, $zero, saida   #Se $t0 = 0 o loop encerra. COndicao de parada.

    addi $s3, $s3, 1  #Aqui o i recebe 1, i++. $s3 = $s3 + 1 (ou i = i + 1) é o contador

    li $v0, 4       #Chamada para comparar
    la $a0, comparar
    syscall

    li $v0, 5       #Segundo valor da comparacao
    syscall

    move $s2, $v0   #Guardando segundo valor

    blt $s1, $s2, guardaValor   #$s1 <  $s2

    #addi $s3, $s3, 1  #Aqui o i recebe 1, i++. $s3 = $s3 + 1 (ou i = i + 1) é o contador
    j laco  #Jump para voltar ao laco. Instrucao da repeticao
    
    guardaValor:
        move $s1, $s2
        #addi $s3, $s3, 1  #Aqui o i recebe 1, i++. $s3 = $s3 + 1 (ou i = i + 1) é o contador
        j laco  #Jump para voltar ao laco. Instrucao da repeticao

    saida:
        li $v0, 1
        move $a0, $s1
        syscall

        li $v0, 10
        syscall

    invalid:
        li $v0, 4
        la $a0, invalido
        syscall

        li $v0, 10
        syscall
