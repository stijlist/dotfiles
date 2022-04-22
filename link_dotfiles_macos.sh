#!/bin/sh
mkdir -p ~/Library/KeyBindings/ && ln -s ~/dotfiles/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict
ln -s ~/dotfiles/net.somethingdoneright.buskill.plist ~/Library/LaunchAgents/
ln -s ~/dotfiles/hammerspoon_init.lua ~/.hammerspoon/init.lua
