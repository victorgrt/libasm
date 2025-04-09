;int strCmp( const char *s1, const char *s2 )
;{
;    const unsigned char *p1 = ( const unsigned char * )s1;
;    const unsigned char *p2 = ( const unsigned char * )s2;
;
;    while ( *p1 && *p1 == *p2 ) ++p1, ++p2;
;
;    return ( *p1 > *p2 ) - ( *p2  > *p1 );
;}

section .text
    global ft_strcmp

ft_strcmp:
    ; RDI = s1
    ; RSI = s2


.loop:
    mov     al, [rdi]       ; charger un octet depuis s1
    mov     bl, [rsi]       ; charger un octet depuis s2
    
    cmp     al, bl          ; comparer
    jne     .not_equal

    test    al, al
    je      .equal

    inc     rdi             ; s1++
    inc     rsi             ; s2++
    
    jmp     .loop

.not_equal:
    movzx   eax, al         ;
    movzx   ebx, bl         ;
    sub     eax, ebx        ;
    ret

.equal:
    xor     eax, eax; retour 0 si egal
    ret