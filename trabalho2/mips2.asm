.data
a: .byte 0
posicao7: .word 0 
posicao6: .word 0
posicao5: .word 0
posicao4: .word 0 
posicao3: .word 0
posicao2: .word 0
posicao1: .word 0
posicao0: .word 0
saida: .asciiz "\nsaida: "
error: .asciiz "entrada incorreta\n"
Printar: .asciiz "posicao­paridade: "
break_line: .asciiz "\n"


.text
 .globl main
main:

    
li $v0, 5 #chama entrada console
syscall 
sw $v0, a #passa a entrada para s0
lw $s0, a
slti $t0, $s0, 128 #checa se o numero eh menor que 128 
beq $t1, $t0, erro #se for menor manda mensagem de erro e fecha o programa
jal somar
jal print_resultado	
li $v0, 10
syscall #exit
    
somar:
 

andi $v0, $s0, 64 #checa o bit 7
sw $v0, posicao7 #armazena bit da posição 7 da entrada

andi $v0, $s0, 32 #checa o bit 6
sw $v0, posicao6  #armazena bit da posição 6 da entrada

andi $v0, $s0, 16 #checa o bit 5
sw $v0, posicao5 #armazena bit da posição 5 da entrada
    
andi $v0, $s0, 8 #checa o bit 4
sw $v0, posicao4 #armazena bit da posição 4 da entrada
    
andi $v0, $s0, 4 #checa o bit 3
sw $v0, posicao3 #armazena bit da posição 3 da entrada
    
andi $v0, $s0, 2 #checa o bit 2
sw $v0, posicao2 #armazena bit da posição 2 da entrada
    
andi $v0, $s0, 1 #checa o bit 1
sw $v0, posicao1 #armazena bit da posição 1 da entrada
		

lw $t0, posicao7 #transfere o bit da posiçao 7 para t0
add $s5, $s5, $t0 #adiciona ao registrado a quantidade de bits
    
lw $t0, posicao6 #transfere o bit da posiçao 6 para t0
add $s5, $s5, $t0#adiciona ao registrado a quantidade de bits
    
lw $t0, posicao5 #transfere o bit da posiçao 5 para t0
add $s5, $s5, $t0#adiciona ao registrado a quantidade de bits

lw $t0, posicao4 #transfere o bit da posiçao 4 para t0
add $s5, $s5, $t0#adiciona ao registrado a quantidade de bits

lw $t0, posicao3 #transfere o bit da posiçao 3 para t0
add $s5, $s5, $t0#adiciona ao registrado a quantidade de bits

lw $t0, posicao2 #transfere o bit da posiçao 2 para t0
add $s5, $s5, $t0#adiciona ao registrado a quantidade de bits

lw $t0, posicao1 #transfere o bit da posiçao 1 para t0
add $s5, $s5, $t0 #adiciona ao registrado a quantidade de bits

 
li $t1, 64 #t1 = 64
and $s6, $s5, $t1 #primeira parte da soma
la $t4, ($s6)#transferindo
    
li $v0, 0#valores de loop
li $t7, 6


loop_soma: 
#começo do loop
srl $t1, $t1, 1 #mudando o bit referncia pra direita
and $s6, $s5, $t1 #somando para o novo valor
add $t4, $t4, $s6 
addi $v0, $v0, 1 #adicionando na contagem do loop
bne $v0, $t7, loop_soma #retorna para o inicio do loop	
   #saindo do loop
andi $t4, $t4, 1 #testa o primeiro bit para ver se eh par ou impar
beq $t4, $zero, print_resultado #se for par pula para o print
addi $s4, $s4, 1 #armazena bit para print
addi $s0, $s0, 128 #adiciona o bit de paridade
move $v0, $s0 #movendo para outro registrador
sw $v0, posicao0 #palavra somada
    
jr $ra
    
print_resultado:
 
 #prints
 
la $a0, Printar	
li $v0, 4 
syscall
	
li $v0, 1 
move $a0, $s4
syscall

la $a0, saida
	
li $v0, 4 
syscall
	
li $v0, 1
move $a0, $s0
syscall

la $a0, break_line
li $v0, 4
syscall

li $v0, 10
syscall #exit

erro:
la $a0, error #print de error
li $v0, 4
syscall

li $v0, 10
syscall#exit
