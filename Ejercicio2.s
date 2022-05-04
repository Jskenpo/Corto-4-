 @@ codigo de assembler: se coloca en la seccion .text
    .text
    .align		2
    @@ etiqueta "main" llama a la funcion global
    .global		main
    .type		main, %function
main:
    @@ grabar registro de enlace en la pila
    stmfd	sp!, {lr}
    
Ejecicio1:  
    ldr r0, =ejercicio1 // Se carga e imprime un mensaje para indicar donde inicia el ejercicio 1
    bl puts

    ldr r3, =bandera // se carga bandera al registro r3
    ldr r3, [r3]    // se accede al valor de bandera

    ldr r0, =mensajeBandera // se carga mensaje de bandera
    bl puts // se imprime el mensaje de bandera

    ldr r0, =entrada // se carga el tipo de dato a recivir
    ldr r1, =maximo // se establece la variable donde se recivira el valor
    bl scanf
    
    ldr r1, =maximo
    ldr r1, [r1] // se accede al valor de la variable
    cmp r1, #61 // se compara el valor de la variable con el valor de 61
    
    
    addgt r3, r3, #2 // se incrementa el valor de la bandera en 2 si es mayor a 61
    addle r3, r3, #1 // se incrementa el valor de la bandera en 1 si es menor o igual a 61

    ldr r0, =mensaje_salida // se carga mensaje de salida
    mov r1, r3 // se mueve el valor de r3 a r1
    bl printf // se imprime el mensaje de salida

Ejercicio2:
    
    ldr r0,=ejercicio2 // se carga e imprime un mensaje para indicar donde inicia el ejercicio 2
    bl puts

Ciclo: 
    ldr r0,=contador // se carga el contador
    ldr r1,[r0] // se accede al valor del contador

    
    cmp r1, #0  // se compara el valor del contador con 0
    beq fin // si es igual a 0 se salta al fin del ciclo
    
    sub r1,#1 // se decrementa el contador en 1
    str r1,[r0] // se guarda el valor del contador en la variable
    
    ldr r3,=veces // se carga el valor de veces
    ldr r1,[r3] // se accede al valor de veces
    
    lsl r1,#1 // se multiplica el valor de veces por 2
    str r1,[r3] // se guarda el valor de veces en la variable
    
    ldr r0, =mensaje_salida // se carga mensaje de salida
    ldr r1,=veces
    ldr r1,[r1] // se accede al valor de veces
    bl printf // se imprime el mensaje de salida
    
    b Ciclo // se vuelve al inicio del ciclo
    
    

    
fin:
	
    @@ r0, r3 <- 0 como sennal de no error al sistema operativo
    mov	r3, #0
    mov	r0, r3

    @ colocar registro de enlace para desactivar la pila y retorna al SO
    ldmfd	sp!, {lr}
    bx	lr
.data
.align 2

bandera:	.word 0
maximo:	    .word 0
contador:   .word 10
veces:	    .word 1

mensajeBandera:
    .asciz "Ingrese su nota maxima obtenida en examenes cortos\n"
entrada:
    .asciz " %d"
mensaje_salida:
    .asciz "El resultado es: %d\n"
ejercicio1:
    .asciz "\nEjercicio 1\n"
ejercicio2:
    .asciz "\nEjercicio 2\n"
