.data
	peso: .float 0.00
    valor: .float 0.00

.text
main:
	li $v0,5                  
	syscall
	move $s0,$v0
	
	li $t0, 0
	
    laco:   
        beq $s0,$t0, saida	
        addi $t0,$t0,1

        li $v0,6                   
        syscall 
        mov.s $f0, $f0      
        s.s $f0, peso
        
        li $v0,6                  
        syscall            
        mov.s $f0, $f0
        s.s $f0, valor

        l.s $f8, peso

        l.s $f6, valor
        
       jal media

        j laco

    media:
        mul.s $f3, $f8, $f6
        add.s $f4, $f4, $f3
        jr $ra
        
    saida:	
        li $v0,2
        mov.d $f12, $f4
        syscall
        
        li $v0,10
        syscall