assume cs:code

a segment
        db 1,2,3,4,5,6,7,8
a ends

b segment
        db 1,2,3,4,5,6,7,8
b ends

c segment
        db 0,0,0,0,0,0,0,0
c ends

code segment

start:  mov ax,a
        mov es,ax

        mov ax,b
        mov ds,ax

        mov ax,c
        mov ss,ax
        mov sp,08h

        mov bx,7

        mov cx,4
      s:mov ah,es:[bx]
        add ah,ds:[bx]
        mov al,es:[bx-1]
        add al,ds:[bx-1]
        push ax
        sub bx,2
        loop s

        mov ax,4c00h
        int 21h

code ends

end start

