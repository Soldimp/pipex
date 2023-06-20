/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nugarcia  <nugarcia@student.42lisboa.co    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/06/12 11:11:42 by nugarcia          #+#    #+#             */
/*   Updated: 2023/06/19 16:59:21 by nugarcia         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "pipex.h"

int	msg(char *err)
{
	write(2, err, ft_strlen(err));
	return (1);
}

void	msg_error(char *err)
{
	perror(err);
	exit (1);
}
//*envp + 5 to pass foward PATH="
char	*find_path(char **envp)
{
	while (ft_strncmp("PATH", *envp, 4))
		envp++;
	return (*envp + 5);
}
/*  0000644 = read and write permissions for the owner of the 
file and read permissions for the group and others. 
This corresponds to the permissions -rw-r--r-- */

void	close_pipes(t_pipex *pipex)
{
	close(pipex->tube[0]);
	close(pipex->tube[1]);
}

void	parent_free(t_pipex *pipex)
{
	int	i;

	i = 0;
	close(pipex->infile);
	close(pipex->outfile);
	while (pipex->cmd_paths[i])
	{
		free(pipex->cmd_paths[i]);
		i++;
	}
	free(pipex->cmd_paths);
}

int main(int ac, char **av, char **envp) 
{
    t_pipex pipex;
	
   if (ac != 5)
		return (msg(ERR_INPUT));
    pipex.infile = open(av[1], O_RDONLY);
	if (pipex.infile < 0)
		msg_error(ERR_INFILE);
    pipex.outfile = open(av[ac - 1], O_TRUNC | O_CREAT | O_RDWR, 0000644);
	if (pipex.outfile < 0)
		msg_error(ERR_OUTFILE);
    if (pipe(pipex.tube) < 0)
		msg_error(ERR_PIPE);
    pipex.paths = find_path(envp);
    pipex.cmd_paths = ft_split(pipex.paths, ':');
    pipex.pid1 = fork();
	if (pipex.pid1 == 0)
		first_child(pipex, av, envp);
    pipex.pid2 = fork();
	if (pipex.pid2 == 0)
		second_child(pipex, av, envp);
    close_pipes(&pipex);
    waitpid(pipex.pid1, NULL, 0);
	waitpid(pipex.pid2, NULL, 0);
    parent_free(&pipex);
    return 0;
}
