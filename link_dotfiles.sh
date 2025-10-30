#!/bin/sh
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
mkdir -p ~/.config/fish
ln -s ~/dotfiles/config.fish ~/.config/fish/config.fish
# cp ~fish-history-merge/functions/up-or-search.fish ~/.config/fish/functions/up-or-search.fish
