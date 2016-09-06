assume cs:code

data segment

        db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
        db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
        db '1993','1994','1995'
        ;above are the strings of the 21 years

        dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
        dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000
        dd 5937000
        ;above are the incomes of the 21 years

        dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635
        dw 8226,11542,14430,15257,17800
        ;above are numbers of employees of the 21 years

data ends

table segment
        db 21 dup ('year summ ne ?? ')
table ends

stack segment
        dw 0,0,0,0,0,0,0,0
stack ends

code segment

start:  mov ax,stack
        mov ss,ax
        mov sp,16

        mov ax,data
        mov ds,ax

        mov ax,table
        mov es,ax

        mov bx,0
        mov bp,0
       ; mov di,0
        mov cx,21

    s:  push cx

        mov si,0
        mov cx,4
     s1:mov al,ds:[bp+si]
        mov es:[bx+0+si],al

        mov ah,ds:[bp+84+si]
        mov es:[bx+5+si],ah

        inc si
        loop s1

       ; mov si,0
       ; mov cx,2
     ;s2:mov al,ds:[di+168][si]
       ; mov es:[bx+10+si],al
       ; inc si
       ; loop s2

        add bx,16
        add bp,4
       ; add di,2
        pop cx
        loop s

        mov ax,4c00h
        int 21h

code ends

end start
