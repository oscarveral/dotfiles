# If not running interactively, don't do anything.

[[ $- != *i* ]] && return

# Alias definitions.

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Prompt settings.

PS1='[\u@\h \W]\$ '