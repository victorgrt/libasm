;ssize_t read(int fd, void *buf, size_t count);

section .text
    global ft_read

ft_read:
    mov rax, 0         ; syscall read
    syscall            ; exécute le syscall
    
    test rax, 0
    je   error
    
    ret

error:
    mov rax, -1
    ret