.data

.text
    main:
    li $a0, 9  #Multiplicando #Manter esse registrador por enquanto

    li $a1, 3  #Multiplicador

    move $s0, $zero    #Variavel i do loop
    move $a2, $zero    #Iniciando o registrador que vai receber o resultado
    multifac:
        slt $t0, $s0, $a1   # i < n --> $t0=1, se nao $t0=0.
        beq $t0, $zero, resultado

        add $a2, $a2, $a0   #Somando o multiplicando com ele mesmo 
                           
        addi $s0, $s0, 1    #Incremento do loop
            j multifac

    resultado:
        #mfhi rd 
        #mflo $s1

        li $v0, 10
        syscall