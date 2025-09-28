# If not running interactively, don't do anything.

[[ $- != *i* ]] && return

# Alias definitions.

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Prompt settings.

PS1='[\u@\h \W]\$ '

# XDG settings.

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_RUNTIME_DIR="/run/user/$UID"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/etc/xdg"
