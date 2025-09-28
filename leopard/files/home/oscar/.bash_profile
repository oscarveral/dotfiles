# Source bashrc if it exists.

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Change history location.

export HISTFILE="$XDG_STATE_HOME/bash/history"