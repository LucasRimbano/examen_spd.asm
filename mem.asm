;===========================================================
; PARCIAL DE MEMORIA - Juego tipo examen SPD
;-----------------------------------------------------------
; Usa librerías externas:
;   imprimir_pantalla
;   leer_caracter_abc
;   sonido_error
;   sonido_presentacion
;   reg2ascii
;-----------------------------------------------------------
; 5 preguntas, 3 opciones (A, B, C)
; Puntaje mostrado en decimal con reg2ascii
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
msg_intro      db 0dh,0ah,"[UNIDAD: MEMORIA PRINCIPAL]",0dh,0ah
               db "Responde las 5 preguntas del parcial (A, B o C).",0dh,0ah,'$'

msg_correcto   db 0dh,0ah,"✅ Correcto!",0dh,0ah,'$'
msg_incorrecto db 0dh,0ah,"❌ Incorrecto!",0dh,0ah,'$'
msg_final      db 0dh,0ah,"Puntaje final: ",'$'
msg_aprobado   db 0dh,0ah,"Aprobado! Excelente manejo de la memoria 🧠",0dh,0ah,'$'
msg_reprobo    db 0dh,0ah,"Debes repasar el funcionamiento de la memoria 💾",0dh,0ah,'$'

; Preguntas y opciones
preg1 db 0dh,0ah,"1) ¿Qué tipo de memoria es volátil?",0dh,0ah
      db "A) ROM",0dh,0ah,"B) RAM",0dh,0ah,"C) Disco Duro",0dh,0ah,'$'

preg2 db 0dh,0ah,"2) ¿Dónde se almacenan temporalmente los datos en ejecución?",0dh,0ah
      db "A) RAM",0dh,0ah,"B) CPU",0dh,0ah,"C) Registro de Control",0dh,0ah,'$'

preg3 db 0dh,0ah,"3) ¿Qué sucede con los datos de la RAM al apagar la PC?",0dh,0ah
      db "A) Se guardan en ROM",0dh,0ah,"B) Se pierden",0dh,0ah,"C) Se copian al cache",0dh,0ah,'$'

preg4 db 0dh,0ah,"4) ¿Qué bus se usa para acceder a direcciones de memoria?",0dh,0ah
      db "A) Bus de Datos",0dh,0ah,"B) Bus de Control",0dh,0ah,"C) Bus de Direcciones",0dh,0ah,'$'

preg5 db 0dh,0ah,"5) ¿Cuál de estas es una memoria NO volátil?",0dh,0ah
      db "A) ROM",0dh,0ah,"B) RAM",0dh,0ah,"C) Caché",0dh,0ah,'$'

; Buffers
nroAscii db '000','$'   ; Para conversión del puntaje

.code
public jugar_mem

jugar_mem proc
    push ax
    push bx
    push cx
    push dx

    mov bl, 0            ; Contador de respuestas correctas (0–5)

    ;-----------------------------------
    ; Introducción y sonido
    ;-----------------------------------
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

p2:
    ;=============================
    ; PREGUNTA 2
    ;=============================
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

p3:
    ;=============================
    ; PREGUNTA 3
    ;=============================
    lea dx, preg3
    call imprimir_pantalla
    call leer_caracter_abc
    cmp al, 'B'
    je bien3
    call sonido_error
    lea dx, msg_incorrecto
    call imprimir_pantalla
    jmp p4
bien3:
    inc bl
    lea dx, msg_correcto
    call imprimir_pantalla

p4:
    ;=============================
    ; PREGUNTA 4
    ;=============================
    lea dx, preg4
    call imprimir_pantalla
    call leer_caracter_abc
    cmp al, 'C'
    je bien4
    call sonido_error
    lea dx, msg_incorrecto
    call imprimir_pantalla
    jmp p5
bien4:
    inc bl
    lea dx, msg_correcto
    call imprimir_pantalla

p5:
    ;=============================
    ; PREGUNTA 5
    ;=============================
    lea dx, preg5
    call imprimir_pantalla
    call leer_caracter_abc
    cmp al, 'A'
    je bien5
    call sonido_error
    lea dx, msg_incorrecto
    call imprimir_pantalla
    jmp resultado
bien5:
    inc bl
    lea dx, msg_correcto
    call imprimir_pantalla

resultado:
    ;-----------------------------------
    ; Mostrar puntaje usando reg2ascii
    ;-----------------------------------
    lea dx, msg_final
    call imprimir_pantalla

    xor ah, ah
    mov al, bl          ; Cantidad de aciertos
    mov bx, offset nroAscii
    call reg2ascii

    lea dx, nroAscii
    call imprimir_pantalla

    mov dl, '/'
    mov ah, 02h
    int 21h
    mov dl, '5'
    int 21h

    ;-----------------------------------
    ; Mostrar mensaje según resultado
    ;-----------------------------------
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
jugar_mem endp

end
