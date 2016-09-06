assume cs:code
code segment
        mov ax,0ffffh
        mov ds,ax
        mov bx,6      ;above, set ds:bx point to ffff:6

        mov al,[bx]
        mov ah,0      ;above, set (al)=((ds*16)+(bx)), (ah)=0

        mov dx,0      ;set register of cumulation 0

        mov cx,3      ;loop three times
     s: add dx,ax
        loop s        ;above, calculate (ax)*3

        mov ax,4c00h
        int 21h

code ends
end

