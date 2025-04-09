#include "libasm.h"

int main(void)
{
    /*  ft_strlen   */ printf("%s[====== FT_STRLEN ======]%s\n", GREEN, NONE);
    printf("%ld\n", ft_strlen("caca111"));


    /*  ft_strcpy   */ printf("%s[====== FT_STRCPY ======]%s\n", BLUE, NONE);
    char *src = "coucou";
    char *dest = "coucou";

    // strcpy(dest, "coucou");
    // printf("%s\n", dest);

    // ft_strcpy(dest, src);
    // printf("%s\n", dest);
    // ft_strcpy(dest, src);

    /*  ft_strcmp   */ printf("%s[====== FT_STRCMP ======]%s\n", YELLOW, NONE);
    printf("%d\n", strcmp(src, dest));
    printf("%d\n", ft_strcmp(src, dest));


    /*  ft_write   */ printf("%s[====== FT_WRITE ======]%s\n", GRAY, NONE);
    ft_write(1, "test\n", 5);
    printf("%d\n", ft_write(1, "test\n", 5));
    
    
    /*  ft_read   */ printf("%s[====== FT_READ ======]%s\n", CYAN, NONE);
    int fd = open("Makefilee", O_RDONLY);
    char *buff = malloc(6);

    int test_result = read(fd, buff, 5);
    printf("%s\n", buff);
    printf("%d\n", test_result);

    int fd2 = open("Makefilee", O_RDONLY);
    int test2 = ft_read(fd2, buff, 5);
    printf("%s\n", buff);
    printf("%d\n", test2);
    
    /*  ft_strdup   */ printf("%s[====== FT_STRDUP ======]%s\n", PURPLE, NONE);
    // char *test = ft_strdup("coucou!");
    // printf("%s\n", test);


    return 0;
}