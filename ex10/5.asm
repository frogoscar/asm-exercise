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

        dw 21 dup (0)
        ;above are the average income of each employee of the 21 years

data ends

data1 segment
        db 10 dup (0)
data1 ends

stack segment
        db 32 dup (0)
stack ends

code segment

start:  mov ax,stack
        mov ss,ax
        mov sp,32

        mov ax,data
        mov ds,ax

        mov bp,0
        mov si,0

;input the average income of each employee of the 21 years
        mov cx,21
    s:  mov dx,ds:[86+si]
        mov ax,ds:[84+si]
        div word ptr ds:[168+bp]
        mov ds:[210+bp],ax        
        add si,4
        add bp,2
        loop s

;print the first column -- the 21 years:
        mov cx,21
        mov bp,0
     s1:
        ;push cx
        mov ax,data1
        mov es,ax        
        mov bx,data
        mov ds,bx
        mov ax,ds:[bp]
        mov dx,ds:[2+bp]
        push bp
        mov bp,0ah
        mov si,0
        mov di,0

        call ddtoc

        mov ax,bp
        mov dh,4
        div dh
        mov dh,al
        mov dl,0
        mov cl,2

        mov ax,0b800h     
        mov es,ax

        mov ax,data1
        mov ds,ax
        mov si,0
        mov di,0

        call show_str

        pop bp
        add bp,4
        ;pop cx
        loop s1

   ddtoc: call divdw           ;dword type

          add bx,30h
          push bx
          mov es,dx
          or dx,ax       
          mov cx,dx
          mov dx,es
          jcxz ok1
           
          inc si
          jmp ddtoc

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



;print the second column -- the income of the 21 years:
;        mov cx,21
;     s2:
;        loop s2

;print the third column -- the number of employees of the 21 years:
;        mov cx,21
;     s3:
;        loop s3

;print the fourth column -- the average income of each employee of the 21 years:
;        mov cx,21
;     s4:
;        loop s4


        mov ax,4c00h
        int 21h

code ends

end start

