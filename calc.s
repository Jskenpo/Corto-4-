
.text
.align 2
.global main
.type main, %function
main:
stmfd sp!, {lr}
/*impresion de menu y pide comando*/
Menu:
ldr r0,=menu
bl puts
ldr r0,=ingreso
bl puts
ldr r0,=opcion
ldr r1,=comando
bl scanf
/*compara comandos*/
comp:
/*saltos dependiendo de caracter*/
ldr r4,=comando
ldrb r4,[r4]
cmp r4, #'+'
beq suma
cmpne r4, #'-'
beq resta
cmpne r4, #'*'
beq mul
cmpne r4, #'/'
beq div
cmpne r4, #'='
beq Res
cmpne r4, #'q'
beq Salir
bne ErrorCar
/* hace la suma*/
suma:
@ingreso op2
ldr r0,=ingreso_op
bl puts
ldr r0, =entrada
ldr r1,=op2
bl scanf
@validacion
cmp r0,#0
beq Error
@calculo
ldr r6, =op1
ldr r8,[r6]
ldr r7,=op2
ldr r7,[r7]
add r8,r7
@guarda valor
str r8,[r6]
ldr r0,=res
ldr r1,=op1
ldr r1,[r1]
bl printf
b Menu
/*si pone -*/
resta:
@ingreso op2
ldr r0,=ingreso_op
bl puts
ldr r0, =entrada
ldr r1,=op2
bl scanf
@validacion
cmp r0,#0
beq Error
@calculo
ldr r6, =op1
ldr r8,[r6]
ldr r7,=op2
ldr r7,[r7]
sub r8,r7
@guarda y regresa
str r8,[r6]
ldr r0,=res
ldr r1,=op1
ldr r1,[r1]
bl printf
b Menu
/*multiplicacion*/
mul:
@ingreso
ldr r0,=ingreso_op
bl puts
ldr r0, =entrada
ldr r1,=op2
bl scanf
@validacion
cmp r0,#0
beq Error
@calculo
ldr r6, =op1
ldr r8,[r6]
ldr r7,=op2
ldr r7,[r7]
mul r8,r7
@guarda y regresa
str r8,[r6]
ldr r0,=res
ldr r1,=op1
ldr r1,[r1]
bl printf
b Menu
/* si pone / */
div:
@ingreso op2
ldr r0,=ingreso_op
bl puts
ldr r0, =entrada
ldr r1,=op2
bl scanf
@validacion
cmp r0,#0
beq Error
@carga valores
ldr r6, =op1
ldr r8,[r6]
ldr r7,=op2
ldr r7,[r7]
@ciclo de division
mov r10,#0 /*contador*/
ciclo:
add r10,#1
sub r8,r7
cmp r8,#0
bne ciclo
mov r8,r10
@guarda valor y regresa
str r8,[r6]
ldr r0,=res
ldr r1,=op1
ldr r1,[r1]
bl printf
b Menu
@para ver resultado
Res:
/*carga, muestra y regresa*/
ldr r0,=res
ldr r1,=op1
ldr r1,[r1]
bl printf
b Menu
/*salto para error de num*/
Error:
ldr r0,=error
bl puts
bl getchar
b comp
/* salto para error de comando*/
ErrorCar:
ldr r0,=error
bl puts
bl getchar
b Menu
/* si pone q sale*/
Salir:
ldr r0,=adios
bl puts
mov r0, #0
mov r3, #0
ldmfd sp!, {lr}
bx lr
.data
.align 2
op1: .word 0
op2: .word 0
error: .asciz "Ingreso incorrecto"
ingreso: .asciz "Seleccione una de las siguientes opciones: "
ingreso_op: .asciz "Ingrese un valor: "
menu: .asciz "Calculadora\n+. suma\n-. resta\n*. mul\n/. div\n=.
restulado\nq. salir"
entrada: .asciz " %d"
opcion: .asciz " %c"
comando: .byte 0
res: .asciz "La respuesta es: %d\n"
adios: .asciz "Hasta pronto"