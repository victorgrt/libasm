; on fait un syscall avec les bons arguments

;arg1	RDI
;arg2	RSI
;arg3	RDX
;arg4	RCX
;arg5	R8
;arg6	R9

section .text
    global ft_write

ft_write:
    ; write(stdout=1, msg, len)
    mov rax, 1         ; syscall write
    mov rdi, rdi         ; file descriptor: 1 = stdout
    mov rsi, rsi       ; adresse du message
    mov rdx, rdx       ; longueur du message
    syscall            ; exécute le syscall

    ret