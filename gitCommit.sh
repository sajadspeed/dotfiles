#!/bin/sh
echo "Copy nvim config..."
cp -r ~/.config/nvim/ .
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
git add .
git status
echo "Insert your commit message:"
read commitMessage
git commit -m $commitMessage
