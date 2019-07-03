# Set title
export AUTO_TITLE_SCREENS="YES"

# UTF-8 locale
# Fix for tmux adding space after zsh prompt
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Source additional config files
source ~/.zamazon
source ~/.zprompt
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
        tmux -2u new-session -s $tmux_session_name -d
    fi

    if test -z "$TMUX"; then
        (tmux -2u new-session -t $tmux_session_name)
    fi
    
fi

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=$HISTSIZE

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
alias ccat="highlight --out-format=ansi"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias fuck='sudo $(history -p \!\!)'
alias egrep='egrep --color=auto'
alias ls='ls -hN --color=auto --group-directories-first'

# Environment
export BROWSER="firefox"
export EDITOR="vim"
export READER="zathura"
export TERMINAL="st"

# less/man colors
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '\e[1;31m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '\e[1;36m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '\e[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '\e[01;44;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '\e[0m')"; a="${a%_}"
export LESS_TERMCAP_us="$(printf '%b' '\e[01;32m')"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf '%b' '\e[0m')"; a="${a%_}"

if which brew >/dev/null 2>&1; then
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
fi

