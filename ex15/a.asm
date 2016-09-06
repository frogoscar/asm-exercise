assume cs:code

stack segment
        db 128 dup (0)
stack ends

code segment
start:  mov ax,stack
        mov ss,ax
        mov sp,128

        push cs
        pop ds

        mov ax,0
        mov es,ax

        mov si,offset int9     ;source address
        mov di,204h            ;destination address
        mov cx,offset int9end-offset int9
        cld
        rep movsb

        push es:[9*4]
        pop es:[200h]
        push es:[9*4+2]
        pop es:[202h]

        cli
        mov word ptr es:[9*4],204
        mov word ptr es:[9*4+2],0
        sti

        mov ax,4c00h
        int 21h

int9:   push ax
        push bx
        push cx
        push es

        in al,60h

        pushf
        call dword ptr cs:[200h]    ;cause at the moment in "int 9", CS = 0

        cmp al,1eh                  ;through code of A
        jne int9ret

        in al,60h

        pushf
        call dword ptr cs:[200h]

        cmp al,9eh                  ;block code of A
        jne int9ret

        mov ax,0b800h
        mov es,ax
        mov bx,0
        mov cx,2000
   s:   mov byte ptr es:[bx],65
        add bx,2
        loop s

int9ret:pop es
        pop cx
        pop bx
        pop ax
        iret

int9end:nop

code ends

end start
