section .text
    global ft_read
    extern  __errno_location

ft_read:
    mov rax, 0         ; select syscall "read" by putting the id of "read" inside rax
    syscall            ; kernel executes read(fd, buf, size)
                       ;                 read(rdi, rsi, rdx) -> all come from function call
    
    cmp rax, 0         ; after syscall rax = syscall return value so we compare with 0
    jl   error         ; if less than 0 jump to error because syscall error
    
    ret

error:
    neg rax            ; we need to do this because libc expects a positive number and rax is negative
    mov rdi, rax       ; store errno value in rdi because next function call will overwrite negisters
    call __errno_location ; "where is errno stored or this thread?" -> put it inside rax
    mov [rax], rdi
    mov rax, -1
    ret