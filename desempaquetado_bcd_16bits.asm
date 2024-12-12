; multi-segment executable file template.

data segment
    ; add your data here!
    bcd_empaquetado dw 5678h
    ascii db "0000$"
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
    mov ax, bcd_empaquetado
    mov cl, 4
    mov bl, al
    and bl, 0fh
    or bl, 30h
    mov [ascii+3], bl
    mov bl, al
    and bl, 0f0h
    ror bl, cl
    or bl, 30h    
    mov [ascii+2], bl
    mov bl, ah
    and bl, 0fh
    or bl, 30h
    mov [ascii+1], bl
    mov bl, ah
    and bl, 0f0h
    ror bl, cl
    or bl, 30h
    mov [ascii], bl
    lea dx, ascii
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
