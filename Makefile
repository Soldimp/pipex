# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nugarcia < nugarcia@student.42lisboa.co    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/04/05 12:44:28 by nugarcia          #+#    #+#              #
#    Updated: 2023/06/12 11:11:26 by nugarcia         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = pipex

SRCS_NAME =	main.c

CC = cc
CFLAGS = -Wall -Werror -Wextra -Imlx -g -fsanitize=address

RM = rm -rf

HEADER = pipex.h

LIBFT = ./ft_libft/libft.a
LIBFT_PATH = ./ft_libft

FT_PRINTF = ./ft_printf/libftprintf.a
FT_PRINTF_PATH = ./ft_printf

OBJS = $(SRCS_NAME:.c=.o)

all: $(NAME)

$(NAME) : $(OBJS) $(LIBFT) $(FT_PRINTF)
		$(CC) $(CFLAGS) $(OBJS) $(LIBFT) $(FT_PRINTF) -o $(NAME)

$(LIBFT):  $(shell make -C $(LIBFT_PATH) -q)
	make  -s -C $(LIBFT_PATH)
	make bonus  -s -C $(LIBFT_PATH)
	
$(FT_PRINTF):  $(shell make -C $(FT_PRINTF_PATH) -q)
	make  -s -C $(FT_PRINTF_PATH)
		$(CC) -c $(CFLAGS)  $< -o $@

clean:
		make clean -s -C $(LIBFT_PATH)
		rm -rf $(OBJS)

fclean: clean
		make fclean -s -C $(LIBFT_PATH)
		rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re