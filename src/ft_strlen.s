section .text
    global ft_strlen

ft_strlen:
    ; Entrée : RDI = adresse de la chaîne
    ; Sortie : RAX = longueur de la chaîne (en nombre de caractères)
    xor rax, rax            ; RAX = 0 (compteur de longueur)

count_loop:
    cmp byte [rdi], 0       ; fin du mot ?
    je .done
    inc rax                 ; incrémente la longueur
    inc rdi                 ; passe à la lettre suivante
    jmp count_loop          ; Continuer la boucle

.done:
    ret
