assume cs:code

code segment
start:  mov ax,300
        cmp ax,0
        jb exit
        cmp ax,180
        ja exit
        call showsin

 exit:  mov ax,4c00h
        int 21h

showsin:        jmp short show
     table  dw ag0,ag30,ag60,ag90,ag120,ag150,ag180   ;offset address table
     ag0    db '0',0
     ag30   db '0.5',0
     ag60   db '0.866',0
     ag90   db '1',0
     ag120  db '0.866',0
     ag150  db '0.5',0
     ag180  db '0',0

show:   push bx                       
        push es
        push si
        mov bx,0b800h
        mov es,bx

;divide the angel value by 30 to be the offset relative with table,get the
;the offset address of corresponding string,put it into BX

        mov ah,0
        mov bl,30
        div bl
        mov bl,al
        mov bh,0
        add bx,bx
        mov bx,table[bx]

;display the corresponding string of sin(x)

        mov si,160*12+40*2
shows:  mov ah,cs:[bx]
        cmp ah,0
        je showret
        mov es:[si],ah
        inc bx
        add si,2
        jmp short shows
showret:pop si
        pop es
        pop bx
        ret
        
code ends

end start

