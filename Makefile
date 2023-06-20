# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nugarcia  <nugarcia@student.42lisboa.co    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/04/05 12:44:28 by nugarcia          #+#    #+#              #
#    Updated: 2023/06/19 16:57:33 by nugarcia         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = pipex

SRCS_NAME =	main.c\
			proc_child.c

CC = cc
CFLAGS = -Wall -Werror -Wextra -g -fsanitize=address

RM = rm -rf

LIBFT = ./ft_libft/libft.a
LIBFT_PATH = ./ft_libft

OBJS = $(SRCS_NAME:.c=.o)

all: $(NAME)

$(NAME) : $(OBJS) $(LIBFT)
		$(CC) $(CFLAGS) $(OBJS) $(LIBFT)  -o $(NAME)

$(LIBFT):  $(shell make -C $(LIBFT_PATH) -q)
	make  -s -C $(LIBFT_PATH)
	make bonus  -s -C $(LIBFT_PATH)
		
clean:
		make clean -s -C $(LIBFT_PATH)
		rm -rf $(OBJS)

fclean: clean
		make fclean -s -C $(LIBFT_PATH)
		rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re