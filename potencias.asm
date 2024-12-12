; multi-segment executable file template.

data segment
    ; add your data here!
    byte1 db 0ah
    cuadrado db ?
    cubo dw ?
    cuatriple dw ?
    quintuple dw ?
              dw ?
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
    mov ax, 0
    mov al, byte1
    mul byte1
    mov cuadrado, al
    mov bx, 0
    mov bl, byte1
    mul bx
    mov cubo, ax
    mul bx
    mov cuatriple, ax
    mul bx
    mov quintuple, ax
    mov quintuple+2, dx        
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
