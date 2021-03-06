#!/bin/bash

# INSTRUCTIONS FOR BASH RELATED INSTALLATION
chsh -s /bin/bash

# Change iterm to color scheme
#ensuring iterm2 has been installed install the 'solarized2' iterm2 color scheme following these instructions
# Go here: https://gist.github.com/kevin-smets/8568070
# Recommendation - use Solarized Dark or Tango Dark

# Setup git to view completion from command line
brew install bash-git-prompt

# Move bashrc file to appropriate location & run it
cp "$HOME/sites/snehamerica/configfiles/bashrc" "$HOME/.bashrc"
source ~/.bashrc

# Install vim-go
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go

# Move vimrc file to appropriate location & run it
cp "$HOME/sites/snehamerica/configfiles/vimrc" "$HOME/.vimrc"
