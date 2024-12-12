; multi-segment executable file template. 
goto macro x, y 
    mov ah, 2
    mov bh, 0
    mov dh, y
    mov dl, x
    int 10h
endm
limpiaReg macro
    mov ax, 0
    mov bx, 0
    mov cx, 0
    mov dx, 0
endm

print macro texto
    lea dx, texto
    mov ah, 9
    int 21h
endm

hexdex8 macro numero, destino
    limpiaReg
    mov al, numero
    mov bl, diez
    div bx 
    or al, 30h
    or dl, 30h
    mov destino, al
    mov destino+1, dl
endm   

hexdex16 macro numero16, destino16    
    limpiaReg
    mov ax, numero16
    mov bx, 10
    div bx
    or dl, 30h
    mov destino16+3, dl
    mov dx,0
    div bx
    or dl, 30h
    mov destino16+2, dl
    mov dx, 0
    div bx
    or dl, 30h
    mov destino16+1, dl
    mov dx, 0
    div bx
    or dl, 30h
    mov destino16, dl 
endm

dayweek macro valor
    cmp valor, 0   ; Comparar valor con 0 (domingo)
    je imprimir_domingo
    cmp valor, 1   ; Comparar valor con 1 (lunes)
    je imprimir_lunes
    cmp valor, 2   ; Comparar valor con 2 (martes)
    je imprimir_martes
    cmp valor, 3   ; Comparar valor con 3 (miércoles)
    je imprimir_miercoles
    cmp valor, 4   ; Comparar valor con 4 (jueves)
    je imprimir_jueves
    cmp valor, 5   ; Comparar valor con 5 (viernes)
    je imprimir_viernes
    cmp valor, 6   ; Comparar valor con 6 (sábado)
    je imprimir_sabado
    jmp fin_dia    ; Si no coincide con ninguno, salir

imprimir_domingo:
    lea dx, 00      ; Cargar la dirección del texto "domingo"
    mov ah, 9       ; Función para imprimir string
    int 21h
    jmp fin_dia

imprimir_lunes:
    lea dx, 01      ; Cargar la dirección del texto "lunes"
    mov ah, 9
    int 21h
    jmp fin_dia

imprimir_martes:
    lea dx, 02      ; Cargar la dirección del texto "martes"
    mov ah, 9
    int 21h
    jmp fin_dia

imprimir_miercoles:
    lea dx, 03      ; Cargar la dirección del texto "miércoles"
    mov ah, 9
    int 21h
    jmp fin_dia

imprimir_jueves:
    lea dx, 04      ; Cargar la dirección del texto "jueves"
    mov ah, 9
    int 21h
    jmp fin_dia

imprimir_viernes:
    lea dx, 05      ; Cargar la dirección del texto "viernes"
    mov ah, 9
    int 21h
    jmp fin_dia

imprimir_sabado:
    lea dx, 06      ; Cargar la dirección del texto "sábado"
    mov ah, 9
    int 21h
    jmp fin_dia

fin_dia:
endm

monthname macro valor
    cmp valor, 01h   ; Comparar valor con 1 (enero)
    je imprimir_enero
    cmp valor, 02h   ; Comparar valor con 2 (febrero)
    je imprimir_febrero
    cmp valor, 03h   ; Comparar valor con 3 (marzo)
    je imprimir_marzo
    cmp valor, 04h   ; Comparar valor con 4 (abril)
    je imprimir_abril
    cmp valor, 05h   ; Comparar valor con 5 (mayo)
    je imprimir_mayo
    cmp valor, 06h   ; Comparar valor con 6 (junio)
    je imprimir_junio
    cmp valor, 07h   ; Comparar valor con 7 (julio)
    je imprimir_julio
    cmp valor, 08h   ; Comparar valor con 8 (agosto)
    je imprimir_agosto
    cmp valor, 09h   ; Comparar valor con 9 (septiembre)
    je imprimir_septiembre
    cmp valor, 0ah  ; Comparar valor con 10 (octubre)
    je imprimir_octubre
    cmp valor, 0bh  ; Comparar valor con 11 (noviembre)
    je imprimir_noviembre
    cmp valor, 0ch  ; Comparar valor con 12 (diciembre)
    je imprimir_diciembre
    jmp fin_mes    ; Si no coincide con ninguno, salir

imprimir_enero:
    print ene
    jmp fin_mes

imprimir_febrero:
    print feb
    jmp fin_mes

imprimir_marzo:
    print mar
    jmp fin_mes

imprimir_abril:
    print abr
    jmp fin_mes

imprimir_mayo:
    print may
    jmp fin_mes

imprimir_junio:
    print jun
    jmp fin_mes

imprimir_julio:
    print jul
    jmp fin_mes

imprimir_agosto:
    print ago
    jmp fin_mes

imprimir_septiembre:
    print sep
    jmp fin_mes

imprimir_octubre:
    print oct
    jmp fin_mes

imprimir_noviembre:
    print nov
    jmp fin_mes

imprimir_diciembre:
    print dic
    jmp fin_mes

fin_mes:
endm
getdate macro 
    limpiaReg
    mov ah, 2ah
    int 21h
endm
gethour macro
    limpiaReg
    mov ah, 2ch
    int 21h
endm

data segment
    ; add your data here!
    00 db "Domingo $" 
    01 db "Lunes $"
    02 db "Martes $"
    03 db "Miercoles $"
    04 db "Jueves $"
    05 db "Viernes $"
    06 db "Sabado $"
    ene db "Enero $"
    feb db  "Febrero $"
    mar db "Marzo $"
    abr db "Abril $"
    may db  "Mayo $"
    jun db "Junio $"
    jul db "Julio $"
    ago db "Agosto $"
    sep db "Septiembre $"
    oct db "Octubre $"
    nov db "Noviembre $" 
    dic db "Diciembre $"
    day db "00 - $"
    moth db "00 - $"
    year db "0000 $" 
    dia db ?
    mes db ?
    anio dw ?
    dayw db "Dia: $"
    mothw db "Mes: $"
    diez db 10 
    hora db "00:00 $" 
    mins db ?
    hrs  db ?
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

    
    getdate
    mov dia, dl
    mov mes, dh
    mov anio, cx     
    hexdex8 dia, day
    hexdex8 mes, moth
    hexdex16 anio, year
    goto 020h, 0ch
    print day           
    print moth
    print year 
    goto 020h, 0dh
    print dayw
    getdate
    dayweek al
    goto 020h, 0eh
    print mothw
    getdate
    monthname dh 
    gethour
    mov hrs,ch
    mov mins,cl
    limpiaReg
    mov al, hrs
    mov bl, 10
    div bl
    or ah, 30h
    mov hora+1, ah
    or al, 30h
    mov hora, al
    limpiaReg
    mov al, mins
    mov bl, 10
    div bl
    or ah, 30h 
    mov hora+4,ah
    or al, 30h
    mov hora+3,al  
    
    goto 1h, 2h
    print hora
    goto 20h, 0fh
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
