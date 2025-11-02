;===========================================================
; UNIDAD DE INTERRUPCIONES - Examen tipo parcial (versión estable)
;-----------------------------------------------------------
; Usa librerías externas:
;   imprimir_pantalla
;   leer_caracter_abc
;   sonido_error
;   sonido_presentacion
;   reg2ascii
;-----------------------------------------------------------
; 5 preguntas, 3 opciones (A, B, C)
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
msg_intro db 0dh,0ah,"[UNIDAD: INTERRUPCIONES]",0dh,0ah
          db "Responde las 5 preguntas del parcial (A, B o C).",0dh,0ah,'$'

msg_correcto db 0dh,0ah,"✅ Correcto!",0dh,0ah,'$'
msg_incorrecto db 0dh,0ah,"❌ Incorrecto!",0dh,0ah,'$'
msg_final db 0dh,0ah,"Puntaje final: ",'$'
msg_aprobado db 0dh,0ah,"Excelente! Manejás las señales del CPU como un experto en interrupciones ⚡",0dh,0ah,'$'
msg_reprobo db 0dh,0ah,"Necesitás repasar las ISR, los flags y las líneas de control 🧠",0dh,0ah,'$'

preg1 db 0dh,0ah,"1) ¿Qué es una interrupción?",0dh,0ah
      db "A) Una orden de salto condicional",0dh,0ah
      db "B) Una señal que detiene temporalmente la ejecución normal del CPU",0dh,0ah
      db "C) Una instrucción de E/S",0dh,0ah,'$'

preg2 db 0dh,0ah,"2) ¿Qué tipo de interrupciones puede enmascararse?",0dh,0ah
      db "A) Las de software",0dh,0ah
      db "B) Las de hardware enmascarables",0dh,0ah
      db "C) Las no enmascarables (NMI)",0dh,0ah,'$'

preg3 db 0dh,0ah,"3) ¿Qué instrucción se usa para habilitar interrupciones?",0dh,0ah
      db "A) CLI",0dh,0ah
      db "B) STI",0dh,0ah
      db "C) HLT",0dh,0ah,'$'

preg4 db 0dh,0ah,"4) ¿Qué debe contener una rutina de servicio (ISR)?",0dh,0ah
      db "A) Código para manejar el evento y un IRET al final",0dh,0ah
      db "B) Solo datos del evento",0dh,0ah
      db "C) Un bucle infinito",0dh,0ah,'$'

preg5 db 0dh,0ah,"5) ¿Qué hace la instrucción IRET?",0dh,0ah
      db "A) Retorna de una interrupción restaurando flags y punteros",0dh,0ah
      db "B) Detiene el CPU",0dh,0ah
      db "C) Reinicia la pila",0dh,0ah,'$'

nroAscii db '000','$'

.code
public jugar_int

jugar_int proc
    push ax
    push bx
    push cx
    push dx

    mov bl, 0              ; contador de aciertos

    lea dx, msg_intro
    call imprimir_pantalla
    call sonido_presentacion

;-------------------------
; PREGUNTA 1
;-------------------------
    lea dx, preg1
    call imprimir_pantalla
    call leer_caracter_abc
    xor ah, ah
    cmp al, 'B'
    je bien1
    call sonido_error
    lea dx, msg_incorrecto
    call imprimir_pantalla
    jmp p2
bien1:
    inc bl
    call sonido_presentacion
    lea dx, msg_correcto
    call imprimir_pantalla

;-------------------------
; PREGUNTA 2
;-------------------------
p2:
    lea dx, preg2
    call imprimir_pantalla
    call leer_caracter_abc
    xor ah, ah
    cmp al, 'B'
    je bien2
    call sonido_error
    lea dx, msg_incorrecto
    call imprimir_pantalla
    jmp p3
bien2:
    inc bl
    call sonido_presentacion
    lea dx, msg_correcto
    call imprimir_pantalla

;-------------------------
; PREGUNTA 3
;-------------------------
p3:
    lea dx, preg3
    call imprimir_pantalla
    call leer_caracter_abc
    xor ah, ah
    cmp al, 'B'
    je bien3
    call sonido_error
    lea dx, msg_incorrecto
    call imprimir_pantalla
    jmp p4
bien3:
    inc bl
    call sonido_presentacion
    lea dx, msg_correcto
    call imprimir_pantalla

;-------------------------
; PREGUNTA 4
;-------------------------
p4:
    lea dx, preg4
    call imprimir_pantalla
    call leer_caracter_abc
    xor ah, ah
    cmp al, 'A'
    je bien4
    call sonido_error
    lea dx, msg_incorrecto
    call imprimir_pantalla
    jmp p5
bien4:
    inc bl
    call sonido_presentacion
    lea dx, msg_correcto
    call imprimir_pantalla

;-------------------------
; PREGUNTA 5
;-------------------------
p5:
    lea dx, preg5
    call imprimir_pantalla
    call leer_caracter_abc
    xor ah, ah
    cmp al, 'A'
    je bien5
    call sonido_error
    lea dx, msg_incorrecto
    call imprimir_pantalla
    jmp resultado
bien5:
    inc bl
    call sonido_presentacion
    lea dx, msg_correcto
    call imprimir_pantalla

;-------------------------
; RESULTADO FINAL
;-------------------------
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
jugar_int endp

end
