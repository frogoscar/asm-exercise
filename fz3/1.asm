assume cs:code
code segment
s:      jmp s
        jmp short s
        jmp near ptr s
        jmp far ptr s
code ends
end s
