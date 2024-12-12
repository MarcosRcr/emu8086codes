; Multi-segment executable file template with repeat functionality.

; Macro para capturar una cadena de caracteres.
capturar macro destino  
    LOCAL captura_loop, salir
    lea si, destino
    captura_loop:
        mov ah, 1
        int 21h
        cmp al, 0dh    ; Enter presionado
        je salir
        mov [si], al
        inc si
        jmp captura_loop
    salir:
        nop
endm

; Macro para posicionar el cursor.
cursor macro x, y
    mov ah, 02h
    mov bh, 0
    mov dh, x
    mov dl, y
    int 10h
endm

; Macro para limpiar pantalla.
limpieza macro
    mov ah, 06h
    mov al, 0
    mov bh, 0fh
    mov cx, 0
    mov dx, 184fh
    int 10h
endm

; Macro para imprimir texto.
imprimir macro texto
    lea dx, texto
    mov ah, 09h
    int 21h
endm

data segment
    ; Definición de datos.
    titulo db "Lenguajes de bajo nivel", 0ah, 0dh, "$"
    nombre db "Nombre: ", "$"
    boleta db "Boleta: ", "$"
    grupo db "Grupo: ", "$"
    materia db "Materia: ", "$"
    pulsar db "Pulsa ENTER para continuar...", 0ah, 0dh, "$"                                                         
    pregunta db "Desea continuar? [s/n]: $"
    mi_nombre db 16 dup("$$")
    mi_boleta db 8 dup("$$") 
    mi_grupo db 8 dup("$$") 
    mi_materia db 16 dup("$$")
ends

stack segment
    dw 128 dup(0)
ends

code segment
start:
    mov ax, data
    mov ds, ax
    mov es, ax

repeat_program:
    ; Limpia la pantalla.
    limpieza

    ; Mostrar título y capturar datos.
    cursor 0bh, 20h
    imprimir titulo

    cursor 0ch, 20h
    imprimir nombre
    cursor 0ch, 27h
    capturar mi_nombre

    cursor 0dh, 20h
    imprimir boleta
    cursor 0dh, 27h
    capturar mi_boleta

    cursor 0eh, 20h
    imprimir grupo
    cursor 0eh, 27h
    capturar mi_grupo

    cursor 0fh, 20h
    imprimir materia
    cursor 0fh, 28h
    capturar mi_materia

    cursor 10h, 20h
    imprimir pulsar
    ; Espera un ENTER.
    mov ah, 1
    int 21h

    ; Limpia la pantalla y muestra los datos capturados.
    limpieza
    cursor 0bh, 20h
    imprimir mi_nombre
    cursor 0ch, 20h
    imprimir mi_boleta
    cursor 0dh, 20h
    imprimir mi_grupo
    cursor 0eh, 20h
    imprimir mi_materia

    ; Preguntar si desea continuar.
    cursor 0fh, 20h
    imprimir pregunta
    mov ah, 1
    int 21h
    cmp al, 's'   ; Continuar si se presiona 's'.
    je repeat_program

    ; Salida del programa.
    mov ax, 4c00h
    int 21h

ends

end start