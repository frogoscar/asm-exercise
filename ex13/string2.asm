assume cs:code

code segment
start:  mov ax,cs
        mov ds,ax
        mov si,offset str

        mov ax,0
        mov es,ax
        mov di,200h

        mov cx,offset strend-offset str
        cld
        rep movsb

        mov ax,0
        mov es,ax
        mov word ptr es:[7ch*4],200h
        mov word ptr es:[7ch*4+2],0
        mov ax,4c00h
        int 21h

    str:mov bp,0
        mov al,160
        mul dh
        mov bx,ax
        add dl,dl
        
 change:cmp byte ptr [si],0
        je ok    ;if zero,jump out of the loop
        mov ax,0b800h
        mov es,ax
        add bx,bp
        mov dh,0
        mov di,dx
        mov al,[si]
        mov es:[bx+di],al
        mov es:[bx+di+1],cl
        sub bx,bp
        sub di,dx
        add bp,2
        inc si
        jmp short change

     ok:iret
 strend:nop

code ends

end start
