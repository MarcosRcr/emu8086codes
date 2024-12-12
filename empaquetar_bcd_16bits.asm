; multi-segment executable file template.

data segment
    ; add your data here!       
    ascii1 db 31h
    ascii2 db 32h
    ascii3 db 33h
    ascii4 db 34h
    bcd_empaquetado dw ?
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
    mov cl, 4
    mov al, ascii1
    and al, 0fh
    rol al, cl  
    mov bl, ascii2
    and bl, 0fh
    or al, bl
    mov ah, al
    mov al, ascii3
    and al, 0fh
    rol al, cl
    mov bl, ascii4
    and bl, 0fh
    or al,bl
    mov bcd_empaquetado, ax
            
    ;lea dx, pkey
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
