# SS configs

export ANDROID_HOME=$HOME/libraries/android_sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$HOME/.dotnet/tools

#if [[ "$PWD" == "$(dirname ${(q)0}::)" ]]; then
#  script_path="$PWD/${(q)0}::"
#else
#  script_path=$(readlink -f ${(q)0}::)
#fi

#script_path=$(readlink -f ${(q)0}::)
#export RUN_READLINK=$RUN_READLINK-$script_path

#export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
