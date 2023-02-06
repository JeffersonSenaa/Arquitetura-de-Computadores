.data

.text
main:
    multifac:
        li $a0, -3      
        li $a1, 4        

        li $t2, 32      
        li $s1, 0       
        li $t3, 0
        li $t0, 1

        multiplicador:
            and $s0, $a1, $t0
            beq $s0, $zero, loop
            addu $s1, $s1, $a0

        loop:
            jal desloc
            addi $t2, $t2, -1   
            beq $t2, $zero, result
            j multiplicador
        
        desloc:
            sll $t0, $t0, 1
            andi $s2, $s1, 1
            sra $s1, $s1, 1
            srl $t3, $t3, 1
            sll $s2, $s2, 31
            or $t3, $t3, $s2
            jr $ra

        result:
            mtlo $t3
            mthi $s1

            li $v0, 10
            syscall