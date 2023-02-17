.data
    gabarito: .space 1024
    questoes: .space 1024

.text
main:
    li $v0, 5       
    syscall

    move $s0, $v0       # quantidade n

    li $v0, 8           #Leitura do gabarito
    la $a0, gabarito
    la $a1, 1024
    syscall

    la $s1, gabarito

    li $v0, 8           #Leitura das questoes
    la $a0, questoes
    la $a1, 1024
    syscall

    la $s2, questoes      #$s2 guarda a string de questoes

    move $t0, $zero     #Laco
    move $s3, $zero     #Resultado

    laco:
        beq $t0, $s0, saida     # Retorna a saida se $t0 == $s0.

        lb $t1, 0($s1)       #Percorrer a string do gabarito
        lb $t2, 0($s2)       #Percorrer a string das questoes

        beq $t1, $t2, resultado     #Condicao que valida se a questao esta correta

        incremento:
        addi $t0, $t0, 1       #Incremento do while
        addi $s1, $s1, 1       #Incremento para locomover a posicao da string
        addi $s2, $s2, 1       #Incremento para locomover a posicao da string

        j laco

        resultado:             #Rotulo para adicionar o incremento por acerto na questao
            addi $s3, $s3, 1    
            j incremento       #jump para retornar ao laco

saida:
    li $v0, 1       #Impressao do resultado de acertos
    move $a0, $s3
    syscall

    li $v0, 10
    syscall
