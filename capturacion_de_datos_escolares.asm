; multi-segment executable file template.

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
    mov cl, 20h
    mov ch, 0ch
    
    call cursor
    lea dx, titulo
    mov ah, 9
    int 21h
    call cursor
    lea dx, nombre
    mov ah, 9
    int 21h
    mov ch, 0dh
    mov cl, 27h
    call cursor
    lea si, mi_nombre
    call capturar
    mov cl, 20h
    call cursor
    lea dx, boleta
    mov ah, 9
    int 21h
    mov ch, 0fh
    mov cl, 27h
    call cursor
    lea si, mi_boleta
    call capturar
    mov cl, 20h
    call cursor
    lea dx, grupo
    mov ah, 9
    int 21h
    mov cl, 27h
    mov ch, 011h
    call cursor
    lea si, mi_grupo
    call capturar
    mov cl, 20h
    call cursor 
    lea dx, materia
    mov ah, 9
    int 21h    
    mov cl, 28h
    mov ch, 13h
    call cursor
    lea si, mi_materia
    call capturar
    mov cl, 20h
    call cursor
    lea dx, pulsar
    mov ah, 9
    int 21h
    call enter 
    mov cl, 20h
    mov ch, 0ch
    call cursor
    lea dx, mi_nombre
    mov ah, 9
    int 21h
    mov ch, 0dh
    call cursor
    lea dx, mi_boleta
    mov ah, 9
    int 21h
    mov ch, 0eh
    call cursor
    lea dx, mi_grupo
    mov ah, 9
    int 21h
    mov ch, 0fh
    call cursor
    lea dx, mi_materia
    mov ah, 9
    int 21h
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h
    
capturar:
    mov ah, 1
    int 21h
    cmp al, 0dh
    je cursor
    mov [si], al
    inc si
    jmp capturar
cursor:
    mov ah, 02
    mov bh, 0
    mov dh, ch
    inc ch
    mov dl, cl
    int 10h
    ret
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
    ret
        
ends

end start ; set entry point and stop the assembler.
