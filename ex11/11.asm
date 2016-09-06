assume cs:codesg

datasg segment
        db "Beginners's All-purpose Symbolic Instruction Code.",0
datasg ends

codesg segment
begin:  mov ax,datasg
        mov ds,ax
        mov si,0
        call letterc

        mov ax,4c00h
        int 21h

letterc:mov ch,0
        mov cl,[si]
        cmp byte ptr [si],61h
        jb s
        cmp byte ptr [si],7ah
        ja s
        and byte ptr [si],11011111b
      s:jcxz ok
        inc si
        jmp letterc
     ok:ret

codesg ends

end begin
