.data
    prompt: .asciiz "Ingrese un número: "
    result: .asciiz "El número menor es: "

.text
.globl main

main:
    li $t0, 5          # Cantidad de números a ingresar
    li $t1, 0          # Contador
    li $t2, 0x7FFFFFFF # Inicializa el menor con un valor muy alto

input_loop:
    # Imprimir mensaje de entrada
    li $v0, 4
    la $a0, prompt
    syscall

    # Leer número desde la entrada
    li $v0, 5
    syscall
    move $t3, $v0  # Guardar número ingresado en $t3

    # Comparar con el menor actual
    slt $t4, $t3, $t2  # Si $t3 < $t2, $t4 = 1
    beq $t4, $zero, skip_update
    move $t2, $t3  # Actualizar el menor si es necesario

skip_update:
    addi $t1, $t1, 1  # Incrementar contador
    bne $t1, $t0, input_loop  # Repetir hasta ingresar 5 números

    # Imprimir resultado
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $t2  # Mostrar número menor
    syscall

    # Terminar el programa
    li $v0, 10
    syscall
