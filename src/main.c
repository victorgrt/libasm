#include "libasm.h"

static void	print_banner(void)
{
	printf("\n");
	printf("  ========================================================\n");
	printf("  |                  LIBASM  test suite                  |\n");
	printf("  ========================================================\n");
}

static void	print_section(const char *title, const char *color)
{
	printf("\n");
	printf("%s  +------------------------------------------------------+%s\n", color, NONE);
	printf("%s  |  %-52s  |%s\n", color, title, NONE);
	printf("%s  +------------------------------------------------------+%s\n", color, NONE);
	printf("    %-24s | %s\n", "ft (yours)", "original (libc)");
	printf("    ------------------------+--------------------------\n");
}

static void	print_case(const char *description)
{
	printf("\n    test: %s\n", description);
}

static void	print_result_int(int ft_val, int libc_val)
{
	printf("         %-24d | %d\n", ft_val, libc_val);
}

static void	print_result_size_t(size_t ft_val, size_t libc_val)
{
	printf("         %-24zu | %zu\n", ft_val, libc_val);
}

static void	print_result_ssize(ssize_t ft_val, ssize_t libc_val)
{
	printf("         %-24zd | %zd\n", ft_val, libc_val);
}

static void	print_result_str(const char *ft_val, const char *libc_val)
{
	printf("         %-24s | %s\n", ft_val, libc_val);
}

static void	test_strlen(void)
{
	print_section("ft_strlen", GREEN);

	print_case("non-empty string \"hello\"");
	print_result_size_t(ft_strlen("hello"), strlen("hello"));

	print_case("empty string");
	print_result_size_t(ft_strlen(""), strlen(""));
}

static void	test_strcpy(void)
{
	char	ft_dest[20];
	char	libc_dest[20];
	char	ft_fmt[32];
	char	libc_fmt[32];

	print_section("ft_strcpy", BLUE);

	print_case("copy \"42school\" into fresh buffer");
	memset(ft_dest, 'X', sizeof(ft_dest));
	memset(libc_dest, 'X', sizeof(libc_dest));
	ft_strcpy(ft_dest, "42school");
	strcpy(libc_dest, "42school");
	snprintf(ft_fmt, sizeof(ft_fmt), "\"%s\"", ft_dest);
	snprintf(libc_fmt, sizeof(libc_fmt), "\"%s\"", libc_dest);
	print_result_str(ft_fmt, libc_fmt);

	print_case("copy empty string");
	memset(ft_dest, 'X', sizeof(ft_dest));
	memset(libc_dest, 'X', sizeof(libc_dest));
	ft_strcpy(ft_dest, "");
	strcpy(libc_dest, "");
	snprintf(ft_fmt, sizeof(ft_fmt), "\"%s\"", ft_dest);
	snprintf(libc_fmt, sizeof(libc_fmt), "\"%s\"", libc_dest);
	print_result_str(ft_fmt, libc_fmt);
}

static void	test_strcmp(void)
{
	print_section("ft_strcmp", YELLOW);

	print_case("identical strings \"abc\" and \"abc\"");
	print_result_int(ft_strcmp("abc", "abc"), strcmp("abc", "abc"));

	print_case("first string is smaller \"abc\" and \"abd\"");
	print_result_int(ft_strcmp("abc", "abd"), strcmp("abc", "abd"));

	print_case("first string is greater \"abd\" and \"abc\"");
	print_result_int(ft_strcmp("abd", "abc"), strcmp("abd", "abc"));

	print_case("empty strings");
	print_result_int(ft_strcmp("", ""), strcmp("", ""));
}

static void	test_write(void)
{
	print_section("ft_write", GRAY);

	print_case("write \"OK\\n\" to stdout (3 bytes)");
	print_result_ssize(ft_write(1, "OK\n", 3), write(1, "OK\n", 3));

	print_case("invalid file descriptor (-1)");
	print_result_ssize(ft_write(-1, "x", 1), write(-1, "x", 1));
}

static void	test_read(void)
{
	int		fd;
	char	ft_buf[16];
	char	libc_buf[16];
	char	ft_fmt[32];
	char	libc_fmt[32];
	ssize_t	ft_ret;
	ssize_t	libc_ret;

	print_section("ft_read", CYAN);

	fd = open("Makefile", O_RDONLY);
	memset(ft_buf, 0, sizeof(ft_buf));
	ft_ret = ft_read(fd, ft_buf, 5);
	close(fd);

	fd = open("Makefile", O_RDONLY);
	memset(libc_buf, 0, sizeof(libc_buf));
	libc_ret = read(fd, libc_buf, 5);
	close(fd);

	print_case("read 5 bytes from \"Makefile\"");
	snprintf(ft_fmt, sizeof(ft_fmt), "%zd (\"%s\")", ft_ret, ft_buf);
	snprintf(libc_fmt, sizeof(libc_fmt), "%zd (\"%s\")", libc_ret, libc_buf);
	print_result_str(ft_fmt, libc_fmt);

	fd = open("Makefile", O_RDONLY);
	memset(ft_buf, 0, sizeof(ft_buf));
	ft_ret = ft_read(fd, ft_buf, 0);
	close(fd);

	fd = open("Makefile", O_RDONLY);
	memset(libc_buf, 0, sizeof(libc_buf));
	libc_ret = read(fd, libc_buf, 0);
	close(fd);

	print_case("read 0 bytes");
	print_result_ssize(ft_ret, libc_ret);
}

static void	test_strdup(void)
{
	char	*ft_str;
	char	*libc_str;
	char	ft_fmt[32];
	char	libc_fmt[32];

	print_section("ft_strdup", PURPLE);

	print_case("duplicate \"libasm\"");
	ft_str = ft_strdup("libasm");
	libc_str = strdup("libasm");
	snprintf(ft_fmt, sizeof(ft_fmt), "\"%s\"", ft_str);
	snprintf(libc_fmt, sizeof(libc_fmt), "\"%s\"", libc_str);
	print_result_str(ft_fmt, libc_fmt);
	free(ft_str);
	free(libc_str);

	print_case("duplicate empty string");
	ft_str = ft_strdup("");
	libc_str = strdup("");
	snprintf(ft_fmt, sizeof(ft_fmt), "\"%s\"", ft_str);
	snprintf(libc_fmt, sizeof(libc_fmt), "\"%s\"", libc_str);
	print_result_str(ft_fmt, libc_fmt);
	free(ft_str);
	free(libc_str);
}

static void	print_footer(void)
{
	printf("\n");
	printf("  ========================================================\n");
	printf("  |                     end of tests                     |\n");
	printf("  ========================================================\n\n");
}

int	main(void)
{
	print_banner();
	test_strlen();
	test_strcpy();
	test_strcmp();
	test_write();
	test_read();
	test_strdup();
	print_footer();
	return (0);
}
