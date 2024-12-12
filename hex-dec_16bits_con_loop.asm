data segment
    hexN dw 0ffffh           
    decN db "00000$"          
    diez db 10              
ends

stack segment
    dw 128 dup(0)
ends

code segment
start:
    ; Configuración de registros de segmento
    mov ax, data
    mov ds, ax
    mov es, ax

    ; Inicialización
    mov ax, hexN      ; Cargar el valor hexadecimal en AX
    mov bl, diez      ; Dividir entre 10
    lea di, decN + 4  ; Apuntar al final de la cadena (antes del terminador '$')
    mov cx, 5         ; Contador para 5 dígitos

ciclo:
    div bx            ; AX / BX, cociente en AX, residuo en DX
    or dl, 30h       ; Convertir el residuo a ASCII
    mov [di], dl      ; Almacenar el dígito en la cadena
    dec di            ; Mover al dígito anterior
    mov dx, 0        ; Limpiar DX para la próxima división
    loop ciclo        ; Repetir hasta completar los dígitos

    ; Mostrar la cadena
    lea dx, decN      ; Cargar la dirección de la cadena
    mov ah, 9
    int 21h           ; Imprimir la cadena

    ; Esperar una tecla
    mov ah, 1
    int 21h

    ; Salir al sistema operativo
    mov ax, 4c00h
    int 21h
ends

end start
