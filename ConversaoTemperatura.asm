.data
    temp1: .space 10
    temp2: .space 10
    valor: .float 0.0
    c: .asciiz "c"
    k: .asciiz "k"
    f: .asciiz "f"
    igual: .asciiz "Valores Iguais\n"
        celsiu: .asciiz "Escala celsius\n"
.text
main:
    li $v0, 8
    la $a0, temp1
    la $a1, 10
    syscall
    la $s0, temp1   #Escala de entrada

    li $v0, 8
    la $a0, temp2
    la $a1, 10
    syscall
    la $s1, temp2   #Escala de saida

    li $v0, 6
    syscall
    mov.s $f0, $f0

    s.s $f0, valor

    lb $t0, ($s0)  
    lb $t1, ($s1)

    la $t2, c
    la $t3, k
    la $t4, f

    beq $t0, $t1, iguais     #Se as escalas forem iguais
    beq $t0, $t2, celsius

    j saida

    iguais:
        li $v0, 4
        la $a0, igual
        syscall

        l.s $f12, valor
        li $v0, 2
        syscall

        j saida

    celsius:
        li $v0, 4
        la $a0, celsiu
        syscall

        j saida

    saida:
        li $v0, 10
        syscall