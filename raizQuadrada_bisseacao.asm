.data
    invalid: .asciiz "Entradas invalidas."
    limit:   .asciiz "Nao foi possivel calcular sqrt("
    limit2:  .asciiz ")."
    msgResult: .asciiz "A raiz quadrada de "
    msgResult1: .asciiz " eh "
    msgResult2: .asciiz ", calculada em "
    msgResult3: .asciiz " iteracoes."

.text
main:
        li $v0, 5       #Entrada dos valores
        syscall
        move $s0, $v0   

        li $v0, 5
        syscall         
        move $s1, $v0   

        ble $s0, 1, invalido        #Condicoes para verificar se os numeros sao validos    
        blt $s1, 1, invalido                   
        bgt $s1, 16, invalido     

        mtc1.d $s1, $f16            #Conversao dos numeros lidos para double   
        cvt.d.w $f16, $f16 

        mtc1.d $s0, $f0             #Conversao dos numeros lidos para double
        cvt.d.w $f0, $f0

        li.d $f8, 10.0  
        li.d $f10, 1.0
        li.d $f26, 1.0
        li.d $f30, 1.0

        li $t1, 0
    tolerancia:                     #Ajuste da tolerancia. Recebe x e calcula para 10^-x
        mul.d $f10, $f10, $f8   
        div.d $f14, $f16, $f10    

        addi $t1, $t1, 1
        bgt $t1, $s1, valorA
        j tolerancia

    valorA:                         #Metodo para encontrar o valor a
        mul.d $f28, $f26, $f26      #O valor a é o valor anterior da raiz
        c.lt.d $f0, $f28            #O metodo trata-se de um loop que vai de 1 ate um numero que seu 
        bc1t valorB                 #quadrado é maior que o valor x. A cada iteracao guarda o numero
        mov.d $f22, $f26            #Anterior. Quando encontra esse valor para o loop e utiliza o numero
        add.d $f26, $f26, $f30      #Anterior como a ($f22) e o seguinte como b para encontrar o intervalo de convergencia
        j valorA

    valorB:                         #b = x/a
        div.d $f2, $f0, $f22         

        li.d $f24, 2.0
        li $t0, 1            
    iteracao:                       #loop de iteracoes
        addi $t0, $t0, 1

        add.d $f20, $f22, $f2     
        div.d $f18, $f20, $f24    

        div.d $f6, $f0, $f18     

        mov.d $f22, $f18         
        mov.d $f2, $f6         

    epsilon:
        c.lt.d $f18, $f6
        bc1t troca
        sub.d $f4, $f18, $f6
        c.le.d $f4, $f14        
        bc1t saida

        beq $t0, 100, limite
    j iteracao  

    troca:
        sub.d $f4, $f6, $f18
        c.le.d $f4, $f14        
        bc1t saida
        beq $t0, 100, limite
    j iteracao

    invalido:
        li $v0, 4
        la $a0, invalid   
        syscall

    j termino

    limite:
        li $v0, 4
        la $a0, limit
        syscall

        li $v0, 1
        move $a0, $s0
        syscall

        li $v0, 4
        la $a0, limit2   
        syscall

       j termino

    saida:
        li $v0, 4
        la $a0, msgResult
        syscall

        li $v0, 1
        move $a0, $s0
        syscall

        li $v0, 4
        la $a0, msgResult1
        syscall

        li $v0, 3
        mov.d $f12, $f18
        syscall

        li $v0, 4
        la $a0, msgResult2
        syscall

        li $v0, 1
        move $a0, $t0
        syscall

        li $v0, 4
        la $a0, msgResult3
        syscall

    termino:
        li $v0, 10
        syscall