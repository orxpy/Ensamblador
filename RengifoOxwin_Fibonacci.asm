.data
    msg_pedir: .asciiz "Ingrese la cantidad de números de la serie de Fibonacci: "
    msg_resultado: .asciiz "\nLa serie de Fibonacci es:\n"
    msg_suma: .asciiz "\nLa suma total de los números de la serie es: "
    salto_linea: .asciiz "\n"

.text
    .globl main

main:
    # Mostrar mensaje para pedir la cantidad de números
    li $v0, 4
    la $a0, msg_pedir
    syscall

    # Leer número desde consola
    li $v0, 5
    syscall
    move $t0, $v0  # Guardamos el número ingresado en $t0

    # Mostrar mensaje "La serie de Fibonacci es:"
    li $v0, 4
    la $a0, msg_resultado
    syscall

    # Inicializar primeros valores de Fibonacci
    li $t1, 0      # Primer número de Fibonacci
    li $t2, 1      # Segundo número de Fibonacci
    li $t3, 0      # Suma total de los números de Fibonacci

    # Imprimir primer número
    li $v0, 1
    move $a0, $t1
    syscall

    # Agregar un salto de línea
    li $v0, 4
    la $a0, salto_linea
    syscall

    # Sumar a la suma total
    add $t3, $t3, $t1

    # Verificar si se debe imprimir más números
    beq $t0, 1, mostrar_suma

    # Imprimir segundo número
    li $v0, 1
    move $a0, $t2
    syscall

    # Agregar un salto de línea
    li $v0, 4
    la $a0, salto_linea
    syscall

    # Sumar a la suma total
    add $t3, $t3, $t2

    # Bucle para calcular e imprimir la serie
    sub $t0, $t0, 2  # Ajustamos el contador (ya imprimimos 2 números)

loop:
    beq $t0, 0, mostrar_suma  # Si el contador llega a 0, mostramos la suma

    # Calcular siguiente número de Fibonacci
    add $t4, $t1, $t2  

    # Imprimir el número
    li $v0, 1
    move $a0, $t4
    syscall

    # Agregar un salto de línea
    li $v0, 4
    la $a0, salto_linea
    syscall

    # Sumar a la suma total
    add $t3, $t3, $t4  

    # Actualizar valores para la siguiente iteración
    move $t1, $t2
    move $t2, $t4

    sub $t0, $t0, 1  # Decrementar contador
    j loop           # Repetir el ciclo

mostrar_suma:
    # Mostrar mensaje "La suma total de los números de la serie es: "
    li $v0, 4
    la $a0, msg_suma
    syscall

    # Imprimir la suma total
    li $v0, 1
    move $a0, $t3
    syscall

    # Agregar un salto de línea final
    li $v0, 4
    la $a0, salto_linea
    syscall

    # Terminar el programa
    li $v0, 10
    syscall
