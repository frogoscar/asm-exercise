assume cs:code

data segment
        db 'conversation',0
data ends

code segment
start:  mov ax,data
        mov ds,ax
        mov si,0

        mov ax,0b800h
        mov es,ax
        mov di,12*160

      s:cmp byte ptr [si],0
        je ok
        mov al,[si]
        mov es:[di],al
        inc si
        add di,2
        mov bx,offset s-offset ok
        int 7ch                   ;turn to the label s
     ok:mov ax,4c00h
        int 21h

code ends

end start


