section .text
    global ft_strcpy

ft_strcpy:
    ; RDI = dest
    ; RSI = src

    mov     rax, rdi        ; sauvegarde de dest pour le return

.loop:
    mov     al, [rsi]       ; charger un octet depuis src
    mov     [rdi], al       ; copier dans dest
    inc     rsi             ; src++
    inc     rdi             ; dest++
    test    al, al          ; est-ce qu'on vient de copier un '\0' ?
    jne     .loop           ; si non, on continue
    ret
