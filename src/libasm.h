#ifndef LIBASM_H
#define LIBASM_H

#define GRAY "\033[1;30m"
#define GREEN "\033[1;32m"
#define YELLOW "\033[1;33m"
#define BLUE "\033[1;34m"
#define PURPLE "\033[1;35m"
#define CYAN "\033[1;36m"
#define NONE "\033[0m"

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>

size_t ft_strlen(char *str);
char* ft_strcpy(char *dest, char *src);
int ft_strcmp(char *dest, char *src);
int ft_write(int fd, char *msg, int len);
size_t ft_read(int fd, void *buf, size_t count);
char    *ft_strdup(char *str);

#endif