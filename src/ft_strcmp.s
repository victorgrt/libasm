; movzx:
; AL = 0x05  → EAX = 0x00000005
; BL = 0x03  → EBX = 0x00000003


section .text
    global ft_strcmp

ft_strcmp:
    ; RDI = s1
    ; RSI = s2


.loop:
    mov     al, [rdi]       ; load one byte of s1 into al
    mov     bl, [rsi]       ; load one byte of s2 into bl
    
    cmp     al, bl          ; compare the two bytes
    jne     .not_equal      ; if not equal then jump to not_equal

    test    al, al          ; is current byt "\0" ?
    je      .equal          ; both strings ended at the same time -> strings are the same

    inc     rdi             ; s1++
    inc     rsi             ; s2++
    
    jmp     .loop           ; repeat loop

.not_equal:
    movzx   eax, al         ; convert from 1 byte to 32 clean bytes
    movzx   ebx, bl         ; convert from 1 byte to 32 clean bytes
    sub     eax, ebx        ; substract s1 -s2 to have correct return value
    ret                     ; return substraction result -> end of function

.equal:
    xor     eax, eax        ; set return value to 0
    ret