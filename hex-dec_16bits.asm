; multi-segment executable file template.

data segment
    ; add your data here!          
    hexN dw 0773Ah
    decN db "00000$"
    diez db 10
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
    mov ax,0    
    mov bx,0
    mov dx,0
    mov ax, hexN
    mov bl, diez
    div bx
    or dx, 30h
    mov decN+4,dl
    mov dx, 0
    div bx
    or dx, 30h
    mov decN+3,dl
    mov dx, 0
    div bx
    or dx, 30h
    mov decN+2,dl
    mov dx, 0
    div bx
    or dx, 30h
    mov decN+1,dl
    mov dx, 0
    div bx
    or dx, 30h
    mov decN,dl
    mov dx, 0
    lea dx, decN               
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
