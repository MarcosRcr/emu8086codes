; multi-segment executable file template.
capturar macro cadena
    LOCAL captura_loop, salir ; Declarar etiquetas locales
    lea si, cadena
    captura_loop:
    mov ah, 1
    int 21h
    cmp al, 0dh
    je salir
    mov [si], al
    inc si
    jmp captura_loop
    salir: nop
endm

cursor macro x,y
    mov ah, 02
    mov bh, 0
    mov dh, x
    inc ch
    mov dl, y
    int 10h
endm
limpieza macro
    enter:
    mov ah, 1
    int 21h
    cmp al, 0dh
    je limpia
limpia:
    mov ah, 06
    mov al, 00
    mov bh, 0fh
    mov cx, 0
    mov dx, 184fh
    int 10h
endm

imprimir macro texto
    lea dx, texto
    mov ah, 9
    int 21h 
endm     
data segment
    ; add your data here!      
    titulo db "Lenguajes de bajo nivel",0ah,0dh,"$"
    nombre db "nombre: ",0ah,0dh,"$"
    boleta db "boleta:",0ah,0dh,"$"
    grupo db "grupo:",0ah,0dh,"$"
    materia db "materia:",0ah,0dh,"$"
    pulsar db "pulsa ENTER para continuar...",0ah,0dh,"$"
    mi_nombre dw 16 dup("$$")
    mi_boleta dw 8 dup("$$")
    mi_grupo dw 8 dup("$$")
    mi_materia dw 16 dup("$$")
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here
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
    
    cursor 010h, 20h
    imprimir pulsar
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
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h
    


  
ends