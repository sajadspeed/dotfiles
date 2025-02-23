#!/bin/sh
echo "Copy nvim config..."
cp -r ~/.config/nvim/ .
 
echo "Copy vim config..."
cp ~/.vimrc ./vim/
 
echo "Copy zsh config..."
echo "\tCopy .zshrc" 
cp ~/.zshrc ./zsh/
echo "\tCopy .zshenv"
cp ~/.zshenv ./zsh/
echo "\tCopy .oh-my-zsh/custom/"
cp -r ~/.oh-my-zsh/custom/ ./zsh/oh-my-zsh/
 
echo "Copy tmux config..."
cp -r ~/.config/tmux/ .
find ./tmux/ -name ".git*" -exec rm -rf {} \; # remove all git repo in tmux directory
 
echo "Copy nvim.profile Konsole..."
cp ~/.local/share/konsole/nvim.profile ./konsole/nvim.profile
 
echo "Copy KwinRules config..."
cp ~/.config/kwinrulesrc ./kde/kwinrulesrc
 
echo "Copy nvim.desktop file..."
cp ~/.local/share/applications/nvim.desktop ./desktop/nvim.desktop
 
echo "Copy firefox userChrome.css"
cp ~/.mozilla/firefox/wbfr5h0b.default-esr/chrome/userChrome.css ./etc/firefox/

echo "Copy yt-dlp config"
cp -r ~/.config/yt-dlp/ ./etc/

echo "Copy .proxychains"
cp ~/.proxychains/proxychains.conf ./etc/proxychains/

echo "Copy Marker user_commands.txt.."
cp ~/.local/share/marker/user_commands.txt ./marker/
 
echo "Copy mpv file..."
cp -r ~/.config/mpv/ .

git add .
git status
echo "Insert your commit message:"
read commitMessage
git commit -m "$commitMessage"
