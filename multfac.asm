.data

.text
main:
   multifac:     
        li $a0, -1000
        li $a1, -170000000

        move $t0, $a0   
        move $t1, $a1   

        addi $t3, $t3, 32    
        addi $t2, $t2, 0       

        slt $t7, $a0, $zero     
        slt $t8, $a1, $zero

        beq $t7, 1, verifica     
        beq $t8, 1, multi_inv

        multi:
            andi $s0, $t1, 1    #Soma por a1
            beq $s0, $zero, loop
            addu $t2, $t2, $t0
            addu $t6, $t6, $a0  

        loop:
            sll	$t0, $t0, 1   
            sra $t1, $t1, 1     
            sra $t6, $t6, 1     
            addi $t3, $t3, -1  
            beq $t3, $zero, result
            j multi

        verifica:
            beq $t8, 1, negativos
            j multi  

        multi_inv:
            andi $s0, $t0, 1        #soma por a0
            beq $s0, $zero, loop2
            addu $t2, $t2, $t1
            addu $t6, $t6, $a1 

        loop2:
            sll	$t1, $t1, 1    
            sra $t0, $t0, 1   
            sra $t6, $t6, 1   
            addi $t3, $t3, -1   
            beq $t3, $zero, result
            j multi_inv

        negativos:
            sub $t0, $zero, $t0
            sub $t1, $zero, $t1
            sub $a1, $zero, $a1
            j multi_inv

        result:
            mtlo $t2
            mthi $t6

            li $v0, 10
            syscall