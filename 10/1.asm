assume cs:code

data segment

        dw 1,2,3,4,5,6,7,8
        dd 0,0,0,0,0,0,0,0

data ends

code segment

 start: mov ax,data
        mov ds,ax
        mov si,0        ;ds:si points to the first group of "word" unit
        mov di,16       ;ds:di points to the second group of "dword" unit

        mov cx,8
     s: mov bx,[si]
        call cube
        mov [di],ax
        mov [di].2,dx
        add si,2        ;ds:si points to the next group of "word" unit
        add di,4        ;ds:di points to the next group of "dword" unit
        loop s

        mov ax,4c00h
        int 21h


;specification: calculate the cube of N
;parameters: (bx)=N
;result: (dx:ax)=N^3
cube:   mov ax,bx
        mul bx
        mul bx
        ret

code ends

end start

