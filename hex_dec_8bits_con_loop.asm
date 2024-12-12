data segment
    hexN db 0ffh         ; Valor hexadecimal (255 en decimal)
    decN db "000$"       ; Cadena para almacenar el n�mero convertido
    diez db 10           ; Valor 10 para divisiones
ends

stack segment
    dw 128 dup(0)
ends

code segment
start:
    ; Configuraci�n de los registros de segmento
    mov ax, data
    mov ds, ax
    mov es, ax

    ; Inicializaci�n
    mov al, hexN         ; Cargar el valor hexadecimal en AL
    mov bl, diez         ; Usar BL como divisor
    lea di, decN + 2     ; Apuntar al final de la cadena (antes del terminador '$')
    mov cx, 3            ; N�mero de d�gitos a calcular

ciclo:
    xor ah, ah           ; Limpiar AH antes de la divisi�n
    div bl               ; AL / BL, cociente en AL, residuo en AH
    add ah, '0'          ; Convertir el residuo a ASCII
    mov [di], ah         ; Almacenar el d�gito en la cadena
    dec di               ; Mover al d�gito anterior
    loop ciclo           ; Repetir hasta completar los d�gitos

    ; Mostrar la cadena
    lea dx, decN         ; Cargar la direcci�n de la cadena
    mov ah, 9
    int 21h              ; Imprimir la cadena

    ; Esperar una tecla
    mov ah, 1
    int 21h

    ; Salir al sistema operativo
    mov ax, 4c00h
    int 21h
ends

end start
