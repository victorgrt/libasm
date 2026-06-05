section .text
    global ft_write
    extern  __errno_location

ft_write:
    mov rax, 1         ; select syscall "read" by putting the id of "read" inside rax
    syscall            ; kernel executes read(fd, buf, size)
                       ;                 read(rdi, rsi, rdx) -> all come from function call
    
    cmp rax, 0         ; after syscall rax = syscall return value so we compare with 0
    jl   error         ; if less than 0 jump to error because syscall error
    
    ret

error:
    neg rax            
    mov rdi, rax
    call __errno_location
    mov [rax], rdi
    mov rax, -1
    ret