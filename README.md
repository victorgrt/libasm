# libasm

Side-by-side view of each function: **C logic** on the left, **matching assembly** in comments.

---

## ft_strlen

```c
size_t ft_strlen(char *str)          // RDI = str
{
    size_t len = 0;                  // xor rax, rax

    while (*str != '\0') {           // cmp byte [rdi], 0  /  je end_loop
        len++;                       // inc rax
        str++;                       // inc rdi
    }                                // jmp count_loop

    return len;                      // end_loop: ret  (RAX = len)
}
```

---

## ft_read

```c
ssize_t ft_read(int fd, void *buf, size_t count)
{                                    // RDI = fd, RSI = buf, RDX = count
    long ret;                        // (kernel result lands in RAX)

    ret = syscall(SYS_read, fd, buf, count);
                                     // mov rax, 0  (syscall id for read)
                                     // syscall

    if (ret < 0)                     // cmp rax, 0  /  jl error
        goto error;

    return ret;                      // ret  (RAX = bytes read)

error:
    int err = -ret;                  // neg rax  (kernel returns -errno)

    *__errno_location() = err;       // mov rdi, rax
                                     // call __errno_location  →  RAX = &errno
                                     // mov [rax], rdi

    return -1;                       // mov rax, -1  /  ret
}
```

**Note:** `0` bytes read is success (end of file). Only a **negative** return from the kernel triggers the error path.
