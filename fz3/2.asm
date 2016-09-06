assume cs:code
code segment
s:      db 100 dup (0b8h,0,0)
        ;jmp short s
        jmp s
        jmp near ptr s
        jmp far ptr s
code ends
end s
