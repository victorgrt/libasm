section .data
    msg db "Hello from 64-bit ASM!", 0xa   ; Le message + saut de ligne
    len equ $ - msg                        ; Taille du message

section .text
    global _start

_start:
    ; write(stdout=1, msg, len)
    mov rax, 1         ; syscall write
    mov rdi, 1         ; file descriptor: 1 = stdout
    mov rsi, msg       ; adresse du message
    mov rdx, len       ; longueur du message
    syscall            ; exécute le syscall

    ; exit(0)
    mov rax, 60        ; syscall exit
    xor rdi, rdi       ; code de sortie: 0
    syscall            ; exécute le syscall
