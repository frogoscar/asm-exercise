assume cs:code

data segment
        db 16 dup (0)
data ends

stack segment
        db 32 dup (0)
stack ends

code segment
start:          mov ax,stack
                mov ss,ax
                mov sp,32

                mov ax,53eah
                mov dx,0013h
                mov bx,data
                mov ds,bx
                mov bp,0ah
                mov si,0
                mov di,0

                call dtoc

                mov dh,8
                mov dl,3
                mov cl,2
        
                mov ax,0b800h     
                mov es,ax
        
                mov ax,data
                mov ds,ax
                mov si,0
                mov di,0

                call show_str

                mov ax,4c00h
                int 21h

            dtoc: call divdw           ;dword type

                  add bx,30h
                  push bx
                  mov es,dx
                  or dx,ax       ;maybe here problem
                  mov cx,dx
                  mov dx,es
                  jcxz ok1
                   
                  inc si
                  jmp dtoc

           divdw: mov bx,ax       ;save the value of ax
                
                  mov ax,dx
                  mov dx,0
                  div bp
                  mov es,ax    ;save the value of the higher 16 bit of the quotient
                                        
                  mov ax,bx
                  div bp
                  mov bx,dx
                  mov dx,es                
                  ret

              ok1:pop bx
                  mov ds:[di],bl
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

