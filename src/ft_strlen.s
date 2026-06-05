section .text
    global ft_strlen

ft_strlen:
    xor rax, rax

count_loop:
    cmp byte [rdi], 0
    je end_loop
    inc rax
    inc rdi
    jmp count_loop

end_loop:
    ret
