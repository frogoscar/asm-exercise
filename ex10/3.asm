assume cs:code

data segment
        db 10 dup (0)
data ends

stack segment
        db 16 dup (0)
stack ends


code segment
start:          mov ax,stack
                mov ss,ax
                mov sp,16

                mov ax,12666
                mov bx,data
                mov ds,bx
                mov si,0
                mov di,0

                call dtoc

                mov dh,8
                mov dl,3
                mov cl,2

                mov ax,stack
                mov ss,ax
                mov sp,16
        
                mov ax,0b800h     
                mov es,ax
        
                mov ax,data
                mov ds,ax
                mov si,0
                mov di,0

                call show_str

                mov ax,4c00h
                int 21h

            dtoc: mov dx,0           ;word type
                  mov bp,0ah
                  div bp
                  add dx,30h
                  push dx                 
                  mov cx,ax
                  jcxz ok1
                   
                  inc si
                  jmp short dtoc

              ok1:pop dx
                  mov ds:[di],dl
                  mov cx,si
                  jcxz ok2
                  inc di
                  dec si
                  jmp short ok1

              ok2:inc di
                  mov al,0
                  mov ds:[di],al
                  ret

        show_str: mov ch,0
                  push cx
        
                  mov cl,ds:[si]
                  mov ch,0
                  jcxz ok3
                          
                  mov al,dh
                  mov bl,160
                  mul bl
                  mov bp,ax
        
                  mov al,dl
                  mov bl,2
                  mul bl
                  mov bx,ax
        
                  add bp,bx
        
                  mov al,ds:[si]
                  mov es:[bp+di],al
                  pop cx
                  mov al,cl
                  mov es:[bp+di+1],al
        
                  inc si
                  add di,2
                  jmp short show_str
        
              ok3:pop cx
                  ret
       
code ends

end start



