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
    entrada:
        li $v0, 5       
        syscall
        move $s0, $v0   

        li $v0, 5
        syscall         
        move $s1, $v0   

        ble $s0, 1, invalido            
        blt $s1, 1, invalido                   
        bgt $s1, 16, invalido     

        mtc1.d $s1, $f16           
        cvt.d.w $f16, $f16 

        mtc1.d $s0, $f0           
        cvt.d.w $f0, $f0

        li.d $f8, 10.0  
        li.d $f10, 1.0
        li.d $f26, 1.0
        li.d $f30, 1.0

        li $t1, 0
    tolerancia:
        mul.d $f10, $f10, $f8   
        div.d $f14, $f16, $f10    

        addi $t1, $t1, 1
        bgt $t1, $s1, valorA
        j tolerancia

    valorA: 
        mul.d $f28, $f26, $f26 
        c.lt.d $f0, $f28
        bc1t valorB
        mov.d $f22, $f26
        add.d $f26, $f26, $f30
        j valorA

    valorB:
        div.d $f2, $f0, $f22         

        li.d $f24, 2.0
        li $t0, 1            
    iteracao:
        addi $t0, $t0, 1

        add.d $f20, $f22, $f2     
        div.d $f18, $f20, $f24    

        div.d $f6, $f0, $f18     

        mov.d $f22, $f18         
        mov.d $f2, $f6         

        jal epsilon
        beq $t0, 100, limite
    j iteracao

    invalido:
        li $v0, 4
        la $a0, invalid   
        syscall

        li $v0, 10
        syscall

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

        li $v0, 10
        syscall

    epsilon:
        c.lt.d $f18, $f6
        bc1t troca
        sub.d $f4, $f18, $f6
        c.le.d $f4, $f14        
        bc1t saida

    retorno:    
        jr $ra    

    troca:
        sub.d $f4, $f6, $f18
        c.le.d $f4, $f14        
        bc1t saida
        j retorno

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

        li $v0, 10
        syscall