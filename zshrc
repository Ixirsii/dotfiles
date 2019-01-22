# Set title
export AUTO_TITLE_SCREENS="YES"

# Source additional config files
source '~/.zamazon'
source '~/.zprompt'
zstyle :compinstall filename '~/.zshrc'

setopt appendhistory autocd extendedglob notify hist_ignore_dups
unsetopt beep nomatch
bindkey -v

autoload -Uz compinit
compinit

tmux_session_name="ryan"

if which tmux >/dev/null 2>&1; then
    #if not inside a tmux session, and if no session is started, start a new session
    if (! tmux has-session -t $tmux_session_name); then
        tmux -2 new-session -s $tmux_session_name -d
    fi

    if test -z "$TMUX"; then
        (tmux new-session -t $tmux_session_name)
    fi
    
fi

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

set-title() {
    echo -e "\e]0;$*\007"
}

ssh() {
    set-title $*;
    /usr/bin/ssh -2 $*;
    set-title $HOST;
}

if [ -f ~/.zshrc-dev-dsk-post ]; then
    source ~/.zshrc-dev-dsk-post
fi

## Aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias fuck='sudo $(history -p \!\!)'
alias egrep='egrep --color=auto'
alias ls='ls --color=auto'

export EDITOR="vim"

if which brew >/dev/null 2>&1; then
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
fi

