;===========================================================
; UNIDAD DE CONTROL - Examen tipo parcial
;-----------------------------------------------------------
; Usa librerías externas:
;   imprimir_pantalla
;   leer_caracter_abc
;   sonido_error
;   sonido_presentacion
;   reg2ascii
;-----------------------------------------------------------
; 5 preguntas, 3 opciones (A, B, C)
; Puntaje mostrado con reg2ascii
;===========================================================

.8086
.model small
.stack 100h

extrn imprimir_pantalla:proc
extrn leer_caracter_abc:proc
extrn sonido_error:proc
extrn sonido_presentacion:proc
extrn reg2ascii:proc

.data
msg_intro db 0dh,0ah,"[UNIDAD: UNIDAD DE CONTROL]",0dh,0ah
          db "Responde las 5 preguntas del parcial (A, B o C).",0dh,0ah,'$'

msg_correcto db 0dh,0ah,"✅ Correcto!",0dh,0ah,'$'
msg_incorrecto db 0dh,0ah,"❌ Incorrecto!",0dh,0ah,'$'
msg_final db 0dh,0ah,"Puntaje final: ",'$'
msg_aprobado db 0dh,0ah,"Excelente! Dominás cómo la CPU coordina y controla sus operaciones ",0dh,0ah,'$'
msg_reprobo db 0dh,0ah,"Necesitás repasar el ciclo de instrucción y el funcionamiento del decodificador de control ⚙️",0dh,0ah,'$'

;--------------------------------------------
; Preguntas
;--------------------------------------------
preg1 db 0dh,0ah,"1) ¿Cuál es la función principal de la Unidad de Control?",0dh,0ah
      db "A) Ejecutar operaciones logicas",0dh,0ah
      db "B) Coordinar y secuenciar las operaciones del CPU",0dh,0ah
      db "C) Guardar datos de usuario",0dh,0ah,'$'

preg2 db 0dh,0ah,"2) ¿Qué hace el decodificador de instrucciones?",0dh,0ah
      db "A) Interpreta las instrucciones y genera señales de control",0dh,0ah
      db "B) Calcula resultados aritméticos",0dh,0ah
      db "C) Guarda datos en RAM",0dh,0ah,'$'

preg3 db 0dh,0ah,"3) ¿Cuál es el ciclo básico de instrucción?",0dh,0ah
      db "A) Fetch - Decode - Execute",0dh,0ah
      db "B) Read - Write - Jump",0dh,0ah
      db "C) Send - Receive - Halt",0dh,0ah,'$'

preg4 db 0dh,0ah,"4) ¿Qué componente ejecuta la instrucción luego de ser decodificada?",0dh,0ah
      db "A) Unidad Aritmético-Lógica (ALU)",0dh,0ah
      db "B) Memoria Principal",0dh,0ah
      db "C) Unidad de Entrada/Salida",0dh,0ah,'$'

preg5 db 0dh,0ah,"5) ¿Qué tipo de control usa una CPU moderna?",0dh,0ah
      db "A) Cableado (Hardwired)",0dh,0ah
      db "B) Microprogramado",0dh,0ah
      db "C) Manual",0dh,0ah,'$'

nroAscii db '000','$'

.code
public jugar_uc

jugar_uc proc
    push ax
    push bx
    push cx
    push dx

    mov bl, 0              ; Contador de respuestas correctas

    lea dx, msg_intro
    call imprimir_pantalla
    call sonido_presentacion

;=============================
; PREGUNTA 1
;=============================
    lea dx, preg1
    call imprimir_pantalla
    call leer_caracter_abc
    cmp al, 'B'
    je bien1
    call sonido_error
    lea dx, msg_incorrecto
    call imprimir_pantalla
    jmp p2
bien1:
    inc bl
    lea dx, msg_correcto
    call imprimir_pantalla

;=============================
; PREGUNTA 2
;=============================
p2:
    lea dx, preg2
    call imprimir_pantalla
    call leer_caracter_abc
    cmp al, 'A'
    je bien2
    call sonido_error
    lea dx, msg_incorrecto
    call imprimir_pantalla
    jmp p3
bien2:
    inc bl
    lea dx, msg_correcto
    call imprimir_pantalla

;=============================
; PREGUNTA 3
;=============================
p3:
    lea dx, preg3
    call imprimir_pantalla
    call leer_caracter_abc
    cmp al, 'A'
    je bien3
    call sonido_error
    lea dx, msg_incorrecto
    call imprimir_pantalla
    jmp p4
bien3:
    inc bl
    lea dx, msg_correcto
    call imprimir_pantalla

;=============================
; PREGUNTA 4
;=============================
p4:
    lea dx, preg4
    call imprimir_pantalla
    call leer_caracter_abc
    cmp al, 'A'
    je bien4
    call sonido_error
    lea dx, msg_incorrecto
    call imprimir_pantalla
    jmp p5
bien4:
    inc bl
    lea dx, msg_correcto
    call imprimir_pantalla

;=============================
; PREGUNTA 5
;=============================
p5:
    lea dx, preg5
    call imprimir_pantalla
    call leer_caracter_abc
    cmp al, 'B'
    je bien5
    call sonido_error
    lea dx, msg_incorrecto
    call imprimir_pantalla
    jmp resultado
bien5:
    inc bl
    lea dx, msg_correcto
    call imprimir_pantalla

;=============================
; RESULTADO FINAL
;=============================
resultado:
    lea dx, msg_final
    call imprimir_pantalla

    xor ah, ah
    mov al, bl
    mov bx, offset nroAscii
    call reg2ascii

    lea dx, nroAscii
    call imprimir_pantalla

    mov dl, '/'
    mov ah, 02h
    int 21h
    mov dl, '5'
    int 21h

    cmp bl, 3
    jb reprobo
    lea dx, msg_aprobado
    call imprimir_pantalla
    jmp fin

reprobo:
    lea dx, msg_reprobo
    call imprimir_pantalla

fin:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
jugar_uc endp

end
