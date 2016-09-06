assume cs:code
code segment

        mov ax,0ffffh
        mov ds,ax

        mov ax,0020h
        mov ss,ax

        mov bx,0

        mov cx,12
      s:mov ds:[bx],ss:[bx]
        inc bx
        loop s

        mov ax,4c00h
        int 21h

code ends
end
