section .text
    global ft_strcpy

ft_strcpy:
    mov     rax, rdi

.loop:
    mov     al, [rsi]
    mov     [rdi], al
    inc     rsi
    inc     rdi
    test    al, al
    jne     .loop
    ret
