;This sub-function is used to add two 128-bit datum

add128: push ax
        push cx
        push si
        push di

        sub ax,ax   ;set CF 0

        mov cx,8
      s:mov ax,[si]
        adc ax,[di]
        mov [si],ax
        inc si
        inc si
        inc di
        inc di    ;can not replace the four inc sub-statement with 
        loop s    ;"add si,2" and "add di,2", cause inc and loop 
                  ;don't affect CF
        pop di
        pop si
        pop cx
        pop ax
        ret

        
