assume cs:code

stack segment
        db 128 dup (0)
stack ends

data segment
        dw 0,0
data ends

code segment
start:  mov ax,stack
        mov ss,ax
        mov sp,128

        mov ax,data
        mov ds,ax

        mov ax,0
        mov es,ax

        push es:[9*4]
        pop ds:[0]
        push es:[9*4+2]
        pop ds:[2]       ;stock the entry address of the original "int 9"

        cli              ;prevent the "keyboard int" occur when setting CS and IP
        mov word ptr es:[9*4],offset int9
        mov es:[9*4+2],cs                 ;put the entry address of the new "int 9"
        sti

        mov ax,0b800h
        mov es,ax
        mov ah,'a'
   s:   mov es:[160*12+40*2],ah
        call delay
        inc ah
        cmp ah,'z'
        jna s

        mov ax,0
        mov es,ax

        push ds:[0]
        pop es:[9*4]
        push ds:[2]
        pop es:[9*4+2]         ;resume the entry address of the original "int 9"

        mov ax,4c00h
        int 21h

delay:  push ax
        push dx
        mov dx,5000h
        mov ax,0
   s1:  sub ax,1
        sbb dx,0
        cmp ax,0
        jne s1
        cmp dx,0
        jne s1
        pop dx
        pop ax
        ret

;----------Below is the new program of "int 9"--------------------------
int9:   push ax
        push bx
        push es

        in al,60h        ;readin the input of the keyboard from the port 60h

        pushf            ;enter the PSW into the stack

        ;cause the IF,TF have been set to 0,0 before entered "int 9"
        ;pushf
        ;pop bx
        ;and bh,11111100b
        ;push bx
        ;popf
        call dword ptr ds:[0]     ;call the original "int 9" by simulating the instruction "int"

        cmp al,1         ;the scan code of "Esc" is 01h
        jne int9ret

        mov ax,0b800h
        mov es,ax
        inc byte ptr es:[160*12+40*2+1]     ;increase the attribute value by 1 to change the color
int9ret:pop es
        pop bx
        pop ax
        iret

code ends

end start






