source ~/.zprompt
zstyle :compinstall filename '/home/ryan/.zshrc'

setopt appendhistory autocd extendedglob notify hist_ignore_dups
unsetopt beep nomatch
bindkey -v

autoload -Uz compinit
compinit

if ( tmux -q has-session -t ryan ); then
    tmux new-session -t ryan
else
    tmux -2 new-session -s ryan -d
    tmux new-session -t ryan
fi

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
## Aliases
alias arm='sudo -u tor arm'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias fuck='sudo $(history -p \!\!)'
alias egrep='egrep --color=auto'
alias ls='ls --color=auto'

export EDITOR="vim"
export PATH=$PATH:$HOME/bin
