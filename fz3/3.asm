assume cs:code
code segment
begin:  jmp short s
        jmp s
        jmp near ptr s
        jmp far ptr s
    s:  mov ax,0
code ends
end begin
