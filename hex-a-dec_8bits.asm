data segment
    hexN db 0FFh        ; Número en hexadecimal a convertir
    decN db "000$"      ; Cadena para mostrar el número convertido
    diez db 10            ; Valor 10 para división decimal
ends

stack segment
    dw 128 dup(0)         ; Espacio para la pila
ends

code segment
start:
    ; Configurar los registros de segmento
    mov ax, data
    mov ds, ax
    mov es, ax
          
    mov ax, 0      
    mov al, hexN
    div diez
    or ah, 30h
    mov decN+2, ah
    mov ah, 0
    div diez
    or ah, 30h
    mov decN+1, ah
    mov ah, 0
    div diez
    or ah, 30h
    mov decN, ah 
    ; Mostrar la cadena resultante
    lea dx, decN
    mov ah, 9
    int 21h               ; Mostrar cadena en pantalla

    ; Esperar por una tecla
    mov ah, 1
    int 21h

    ; Salir al sistema operativo
    mov ax, 4C00h
    int 21h
ends

end start ; Punto de entrada y fin del ensamblado
