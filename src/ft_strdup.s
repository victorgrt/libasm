;arg1	RDI
;arg2	RSI
;arg3	RDX
;arg4	RCX
;arg5	R8
;arg6	R9
;extern malloc
;call malloc

section .text
    global ft_strdup
    extern ft_strlen
    extern ft_strcpy

ft_strdup:
    ; rdi = pointeur vers la chaîne source

    ; 1. Calculer la longueur de la chaîne
    extern malloc
    push rdi                ; on sauvegarde rdi (l'adresse de src)
    call ft_strlen          ; rdi contient src → rax = longueur
    inc rax                 ; +1 pour le '\0'
    
    ; 2. Appeler malloc
    mov rdi, rax            ; taille → rdi
    call malloc             ; malloc(size) → rax = adresse allouée
    
    ; 3. Si malloc a échoué
    test rax, rax
    je .error

    ; 4. Copier la chaîne
    mov rdi, rax            ; rdi = dest
    pop rsi                 ; rsi = src (récupéré du push)
    call ft_strcpy

    ; 5. Retourner l'adresse du buffer alloué
    mov rax, rdi
    ret

.error:
    mov rax, 0
    ret
