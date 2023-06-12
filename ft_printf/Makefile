# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nugarcia < nugarcia@student.42lisboa.co    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/14 11:59:09 by nugarcia          #+#    #+#              #
#    Updated: 2022/11/30 11:14:26 by nugarcia         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = libftprintf.a
SRC = ft_numb ft_printf ft_words\

CC = cc
RM = rm -f
CFLAGS = -Wall -Werror -Wextra
#'ar rc' is the command used to create libraries: c means the library 
#will be created if it does not exist, 
#and r that new objects replace old objects with the same name (if any).
all: $(NAME)
$(NAME) : $(SRC:=.o)
	ar rc $(NAME) $(SRC:=.o)
clean:
	$(RM) $(SRC:=.o)
fclean: clean
	$(RM) $(NAME)
re: fclean $(NAME)
