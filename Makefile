NAME = libasm

NAME_LIB = libasm.a

SRCS = 	./src/ft_write.s \
		./src/ft_read.s \
		./src/ft_strcmp.s \
		./src/ft_strcpy.s \
		./src/ft_strdup.s \
		./src/ft_strlen.s \

CC = gcc

CFLAGS = -Wall -Wextra -Werror 

NASM = nasm

NASMFLAGS = -f elf64

OBJ = $(SRCS:.s=.o)

%.o : %.s
	$(NASM) $(NASMFLAGS) $< -o $@

all : $(NAME)

$(NAME) : $(OBJ)
	ar rcs $(NAME_LIB) $(OBJ)
	$(CC) -o prog $(CFLAGS) ./src/main.c $(NAME_LIB)

clean :
	@echo -n 🚮 rm -f $(OBJ)
	@echo ""

fclean : clean
	@echo -n 🚮 rm -f $(NAME_LIB)
	@echo ""
	@echo -n 🚮 rm -f ./prog
	@sleep 0.2
	@echo "\n✅Cleaned files:"
	@sleep 0.2
	@echo $(NAME_LIB)
	@echo $(OBJ)
	@echo ./prog

re : fclean all