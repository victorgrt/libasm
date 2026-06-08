NAME = libasm.a

SRCS =	./src/ft_write.s \
		./src/ft_read.s \
		./src/ft_strcmp.s \
		./src/ft_strcpy.s \
		./src/ft_strdup.s \
		./src/ft_strlen.s

CC = gcc

CFLAGS = -Wall -Wextra -Werror

NASM = nasm

NASMFLAGS = -f elf64

OBJ = $(SRCS:.s=.o)

all: $(NAME) prog

$(NAME): $(OBJ)
	ar rcs $(NAME) $(OBJ)

prog: $(NAME) src/main.c src/libasm.h
	$(CC) $(CFLAGS) src/main.c $(NAME) -o prog

%.o: %.s
	$(NASM) $(NASMFLAGS) $< -o $@

clean:
	rm -f $(OBJ)

fclean: clean
	rm -f $(NAME) prog

re: fclean all

exec: all
	./prog

.PHONY: all clean fclean re exec prog
