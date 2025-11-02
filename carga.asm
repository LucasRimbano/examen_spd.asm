;===========================================================
; LIBABC - Lee solo caracteres A, B o C (con limpieza de ENTER)
;-----------------------------------------------------------
; Entrada: ninguna
; Salida:  AL = 'A', 'B' o 'C'
;-----------------------------------------------------------
; Si el usuario ingresa otra cosa, muestra mensaje de error
; y vuelve a pedir.
;===========================================================

.8086
.model small
.stack 100h

.data
msg_error db 0dh,0ah,"Solo se permiten las letras A, B o C. Intente de nuevo:",0dh,0ah,'$'

.code
public leer_caracter_abc
extrn imprimir_pantalla:proc
extrn sonido_error:proc

leer_caracter_abc proc
    push dx

pedir:
    ;-----------------------------------------
    ; Leer un carácter del teclado
    ;-----------------------------------------
    mov ah, 01h
    int 21h
    cmp al, 0dh           ; ¿ENTER?
    je pedir              ; Si presiona ENTER, seguir pidiendo

    ;-----------------------------------------
    ; Pasar a mayúscula si es minúscula
    ;-----------------------------------------
    cmp al, 'a'
    jb verificar
    cmp al, 'z'
    ja verificar    
    sub al, 20h           ; convertir a mayúscula

verificar:
    cmp al, 'A'
    je valido
    cmp al, 'B'
    je valido
    cmp al, 'C'
    je valido

    ;-----------------------------------------
    ; Error → sonido + mensaje
    ;-----------------------------------------
    
    call sonido_error
    lea dx, msg_error
    call imprimir_pantalla
    jmp pedir

valido:
    pop dx
    ret
leer_caracter_abc endp

end
