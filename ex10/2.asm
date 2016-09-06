assume cs:code

code segment
start:  mov ax,9f00h
        mov dx,0024h
        mov cx,0dh
        call divdw

        mov ax,4c00h
        int 21h

  divdw:mov bp,ax       ;save the value of ax

        mov ax,dx
        mov dx,0
        div cx
        mov di,ax       ;save the value of the higher 16 of the quotient
                        
        mov ax,bp
        div cx
        mov cx,dx
        mov dx,di

        ret

code ends

end start
