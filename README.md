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

## ft_strcpy

```c
char *ft_strcpy(char *dest, char *src) // RDI = dest, RSI = src
{
    char *ret = dest;                // mov rax, rdi  (save dest for return)

    while (1) {                      // .loop:
        char c = *src;               // mov al, [rsi]  (load from memory)
        *dest = c;                   // mov [rdi], al  (store to memory)
        dest++;                      // inc rdi
        src++;                       // inc rsi
        if (c == '\0')               // test al, al  /  jne .loop
            break;
    }

    return ret;                      // ret  (RAX = original dest)
}
```

**Note:** `mov` always copies `source → destination`. `mov al, [rsi]` reads a byte from `src` (load). `mov [rdi], al` writes it to `dest` (store). `mov rax, rdi` copies the pointer into RAX because RDI moves during the loop but `strcpy` must return the **initial** `dest`.

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

---

## ft_write

```c
ssize_t ft_write(int fd, const void *buf, size_t count)
{                                    // RDI = fd, RSI = buf, RDX = count
    long ret;                        // (kernel result lands in RAX)

    ret = syscall(SYS_write, fd, buf, count);
                                     // mov rax, 1  (syscall id for write)
                                     // syscall

    if (ret < 0)                     // cmp rax, 0  /  jl error
        goto error;

    return ret;                      // ret  (RAX = bytes written)

error:
    int err = -ret;                  // neg rax  (kernel returns -errno)

    *__errno_location() = err;       // mov rdi, rax  (save err before call)
                                     // call __errno_location  →  RAX = &errno
                                     // mov [rax], rdi  (*errno = err)

    return -1;                       // mov rax, -1  /  ret
}
```

**Note:** Same structure as `ft_read`, but syscall id is **1** instead of **0**. On error, `mov [rax], rdi` writes the errno **into memory** at the address returned by `__errno_location` — it does not put the error back inside RAX.

---

## ft_strcmp

```c
int ft_strcmp(char *s1, char *s2)    // RDI = s1, RSI = s2
{
    while (1) {                      // .loop:
        unsigned char c1 = *s1;      // mov al, [rdi]
        unsigned char c2 = *s2;      // mov bl, [rsi]

        if (c1 != c2)                // cmp al, bl  /  jne .not_equal
            return c1 - c2;          // movzx eax, al
                                     // movzx ebx, bl
                                     // sub eax, ebx  /  ret

        if (c1 == '\0')              // test al, al  /  je .equal
            return 0;                // xor eax, eax  /  ret

        s1++;                        // inc rdi
        s2++;                        // inc rsi
    }                                // jmp .loop
}
```

**Note:** `movzx` zero-fills the upper bits of EAX/EBX so the subtraction matches C's `(unsigned char)` cast. `xor eax, eax` clears the full return value — not just AL — so the caller gets exactly `0`, not leftover garbage in the upper bits.

---

## ft_strdup

```c
char *ft_strdup(char *src)           // RDI = src
{
    char *dest;
    size_t size;

    size = ft_strlen(src) + 1;       // push rdi  (save src on stack)
                                     // call ft_strlen  →  RAX = len
                                     // inc rax  (+1 for '\0')

    dest = malloc(size);             // mov rdi, rax  (size → 1st arg)
                                     // call malloc  →  RAX = dest or NULL

    if (dest == NULL)                // test rax, rax  /  je .error
        return NULL;                 // .error: mov rax, 0  /  ret

    ft_strcpy(dest, src);            // mov rdi, rax  (dest → RDI)
                                     // pop rsi  (saved src → RSI, 2nd arg)
                                     // call ft_strcpy

    return dest;                     // mov rax, rdi  /  ret
}
```

**Note:** RDI is reused three times (src → size → dest). `push rdi` / `pop rsi` saves `src` on the stack because `malloc` and `ft_strcpy` need RDI for other arguments. After `pop rsi`: **RDI = dest**, **RSI = src** — exactly what `ft_strcpy(dest, src)` expects.
