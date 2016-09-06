assume cs:code

code segment
start:  mov ax,cs
        mov ds,ax
        mov si,offset do0        ;set ds:si pointed to the source address

        mov ax,0
        mov es,ax
        mov di,200h              ;set es:di pointed to the source address

        mov cx,offset do0end - offset do0
        cld
        rep movsb

        mov ax,0
        mov es,ax
        mov word ptr es:[0*4],200h
        mov word ptr es:[0*4+2],0    ;set the interrupt vector table

        mov ax,4c00h
        int 21h

    do0:jmp short do0start
        db "divide error!"
do0start: mov ax,cs
        mov ds,ax
        mov si,202h               ;set ds:si pointed to the string

        mov ax,0b800h
        mov es,ax
        mov di,12*160+36*2        ;set print in the middle of the screen

        mov cx,13
      s:mov al,[si]
        mov es:[di],al
        inc si
        add di,2
        loop s

        mov ax,4c00h
        int 21h

do0end:nop

code ends

end start



