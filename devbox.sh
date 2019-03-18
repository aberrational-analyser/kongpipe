#!/usr/bin/env bash

# DevBox.sh
#
# In the long run, this ought to be moved out into a chef dev policy.

set -x

echo ---------
echo   installing git
echo ---------
sudo yum install -y git

# curl
echo --------
echo   installing curl

sudo yum install -y curl

# vim
sudo yum install -y vim

# # zsh
# echo ----------
# echo   installing zsh
# sudo yum install -y zsh
# sudo su
# #TODO: This needs work.  Do we want to just be root?
# sudo chsh -s $(which zsh) $(whoami)
# 
# # tmux
# echo ----------
# echo   installing tmux
# sudo yum install -y tmux
# 
# # oh-my-zsh
# echo ---------
# echo   installing oh-my-zsh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# cp .zshrc ~/.zshrc
# source ~/.zshrc
