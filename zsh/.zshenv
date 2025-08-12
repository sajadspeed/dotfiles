
# Prevent duplicate PATH entries in zsh (makes PATH unique)
typeset -U PATH
export ANDROID_HOME=$HOME/libraries/android_sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$HOME/.dotnet/tools
export PATH=$PATH:$HOME/.config/composer/vendor/bin

#export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
