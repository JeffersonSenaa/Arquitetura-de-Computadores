.data

.text
main:
    multifac:
    li $a0, 170000000 #Multiplicando 
    li $a1, 1000  #Multiplicador

    move $s1, $a0
    move $s2, $a1

    move $s0, $zero         #Variavel i do loop
    contador:
        slt $t0, $s0, $s2   # i < n --> $t0=1, se nao $t0=0.
        beq $t0, $zero, resultado

        jal multiplicar     #Salto para a soma salvando a posicao
                           
        addi $s0, $s0, 1    #Incremento do loop
        j contador

    multiplicar:
         addu $s3, $s3, $s1  #Somando o multiplicando com ele mesmo 
         jr $ra             #Salto de retorno ao loop

    resultado:     
        sra $t0, $s3, 31
        mthi $t0            #Esse valor é guardado no registrador alto
        mtlo $s3            #O restante do valor(bits a direita) sao guardadas no registrados baixo

        li $v0, 10          #Comando para finalizar algoritmo
        syscall