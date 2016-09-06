assume cs:code,ss:stack,ds:data

data segment
        db 'Welcome to masm!',0
data ends

stack segment
        db 16 dup (0)
stack ends

code segment
start:  mov dh,8
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

show_str: mov ch,0
          push cx

          mov cl,ds:[si]
          mov ch,0
          jcxz ok
          

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

      ok: pop cx
          ret

code ends

end start
