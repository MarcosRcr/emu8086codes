; multi-segment executable file template.

data segment
    ; add your data here!      
    palabradoble1 dw 0
                  dw 1
    palabra1      dw 3
    cociente      dw ?
    residuo       dw ?
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
    mov ax, palabradoble1
    mov dx, palabradoble1+2
    div palabra1
    mov cociente, ax
    mov residuo, dx        
            
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends

end start ; set entry point and stop the assembler.
