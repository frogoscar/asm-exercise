assume cs:code

code segment
start:  mov ax,00feh
        call showbyte

        mov ax,4c00h
        int 21h

showbyte:       jmp short show
                table  db '0123456789ABCDEF'     ;char table

    show:       push bx
                push es

                mov ah,al
                shr ah,1
                shr ah,1
                shr ah,1
                shr ah,1                  ;right-shift 4 bits, ah gets the higher 4 bits
                and al,00001111b          ;al gets the lower 4 bits

                mov bl,ah
                mov bh,0
                mov ah,table[bx]     ;use value of the higher 4 bits to be the offset relative with table,get the corresponded char

                mov bx,0b800h
                mov es,bx
                mov es:[160*12+40*2],ah

                mov bl,al
                mov bh,0
                mov al,table[bx]    ;use value of the lower 4 bits to be the offset relative with table,get the corresponded char

                mov es:[160*12+40*2+2],al

                pop es
                pop bx

                ret

code ends

end start
        
