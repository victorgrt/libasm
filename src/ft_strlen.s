section .data
    caca db "caca", 0     ; mot avec 0 (NULL) pour fin
    result db "Length: ", 0  ; message affiché avant le chiffre
    digit db 0xa, 0           ; stockage du caractère du chiffre + \n
    ;len equ $ - digit                        ; Taille du message

section .text
    global _start

_start:
    ;-----------------------------
    ; Calcul de la longueur du mot
    ;-----------------------------
    mov rsi, caca     ; adresse du mot
    xor rcx, rcx      ; compteur = 0

count_loop:
    cmp byte [rsi], 0 ; fin du mot ?
    je print_result
    inc rcx           ; incrémente la longueur
    inc rsi           ; passe à la lettre suivante
    jmp count_loop

print_result:
    ; Affiche "Length: "
    
    push rcx
    
    mov rax, 1
    mov rdi, 1
    mov rsi, result
    mov rdx, 8         ; taille de "Length: "
    
    syscall
    ; Convertit la longueur (rcx) en ASCII

    add rcx  , '0'        ; transforme 0 → '0', 1 → '1', etc.
    mov [digit], rcx    ; stocke dans digit

    ; Affiche le chiffre
    mov rax, 1
    mov rdi, 1
    mov rsi, digit
    mov rdx, 2       ; chiffre + \n
    syscall

    ; Quitte le programme
    mov rax, 60
    xor rdi, rdi
    syscall
