programa numero mayor
spoilert: El IDE Mars 4.5 solo funciona con MIPS

Conclusiones sobre el desarrollo del programa y comparación entre MIPS y RISC-V
1. Variaciones en el desarrollo del programa
Durante el desarrollo del programa, se realizaron varias modificaciones para adaptarlo a diferentes entornos y restricciones:

Primera versión (RISC-V)

Se diseñó el código originalmente en RISC-V, utilizando instrucciones como mv, blt y ecall.
Se presentó un error en Mars 4.5 porque este simulador no soporta RISC-V, ya que está basado en MIPS.

Segunda versión (MIPS, con .bss)

Se adaptó el código a MIPS, reemplazando mv por move y ecall por syscall.
Se utilizó la directiva .bss para reservar memoria, lo cual Mars 4.5 no soporta.
Esto generó errores debido a la incompatibilidad de .bss en MIPS.

Tercera versión (MIPS, con .data y alineación)

Se corrigió la reserva de memoria moviendo numbers a la sección .data, usando .space.
Sin embargo, se presentó el error de "store address not aligned on word boundary" porque la memoria reservada no estaba alineada correctamente.
Se corrigió con la directiva .align 2, asegurando que numbers esté alineado a 4 bytes.

Cuarta versión (MIPS, con mensaje inicial)

Se agregó un mensaje de bienvenida antes de solicitar los números.
Se verificó que todas las instrucciones estuvieran dentro del conjunto de comandos permitidos por Mars 4.5.
Finalmente, el programa funciona correctamente en MIPS bajo Mars 4.5.
