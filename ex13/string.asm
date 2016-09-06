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

    str:push si
 change:cmp byte ptr [si],0
        je ok    ;if zero,jump out of the loop

        mov ah,2     ;set the cursor
        mov bh,0     ;the 0th page
        int 10h     

        mov ah,9     ;display the char in the cursor location
        mov al,[si]
        mov bl,cl
        inc si
        mov bh,0
        jmp near ptr change
        int 10h
     ok:pop si
        iret
 strend:nop

code ends

end start
