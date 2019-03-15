#!/usr/bin/env bash

# DevBox.sh
#
# In the long run, this ought to be moved out into a chef dev policy.

# git
sudo yum install -y git

# curl
sudo yum install -y curl

# vim
sudo yum install -y vim

# zsh
sudo yum install -y zsh
sudo chsh -s $(which zsh) $(whoami)

# tmux
sudo yum install -y tmux

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

