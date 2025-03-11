    .data
prompt:   .asciz "Ingrese un número: "
result:   .asciz "El número mayor es: "
newline:  .asciz "\n"

    .bss
numbers:  .space 20  # Espacio para 5 enteros (4 bytes cada uno)

    .text
    .globl main
main:
    li t0, 0              # Contador de números ingresados
    la t1, numbers        # Dirección base del array

input_loop:
    li a7, 4              # Código de syscall para imprimir cadena
    la a0, prompt         # Dirección del mensaje de entrada
    syscall               # Llamar a syscall para imprimir

    li a7, 5              # Código de syscall para leer entero
    syscall               # Leer entero
    sw a0, 0(t1)          # Almacenar número en la dirección actual

    addi t1, t1, 4        # Moverse al siguiente espacio en memoria
    addi t0, t0, 1        # Incrementar contador
    li t2, 5              # Límite de números a leer
    bne t0, t2, input_loop # Repetir si no hemos ingresado 5 números

# Encontrar el número mayor
    la t1, numbers        # Reiniciar t1 al inicio del array
    lw t3, 0(t1)          # Cargar el primer número como máximo
    li t0, 1              # Reiniciar contador

find_max:
    addi t1, t1, 4        # Mover al siguiente número
    lw t4, 0(t1)          # Cargar el siguiente número
    slt t5, t3, t4        # t5 = 1 si t3 < t4
    beq t5, zero, skip    # Si t3 no es menor, saltar
    mv t3, t4             # Actualizar el máximo si t4 es mayor

skip:
    addi t0, t0, 1        # Incrementar contador
    li t2, 5              # Límite de iteraciones
    bne t0, t2, find_max  # Seguir comparando si faltan números

# Mostrar el resultado
    li a7, 4              # Código de syscall para imprimir cadena
    la a0, result         # Dirección del mensaje de salida
    syscall               # Imprimir mensaje

    li a7, 1              # Código de syscall para imprimir entero
    mv a0, t3             # Número mayor encontrado
    syscall               # Imprimir número mayor

    li a7, 4              # Código de syscall para imprimir nueva línea
    la a0, newline        # Dirección del salto de línea
    syscall               # Imprimir nueva línea

    li a7, 10             # Código de syscall para salir
    syscall               # Terminar programa

