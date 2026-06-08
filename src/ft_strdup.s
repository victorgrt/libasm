section .text
    global ft_strdup
    extern ft_strlen
    extern ft_strcpy

ft_strdup:
    extern malloc
    push rdi                
    call ft_strlen          
    inc rax                 
    
    mov rdi, rax            
    call malloc             
    
    test rax, rax
    je .error

    mov rdi, rax            
    pop rsi                 
    call ft_strcpy

    mov rax, rdi
    ret

.error:
    pop rsi
    mov rax, 0
    ret
