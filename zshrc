# Set title
export AUTO_TITLE_SCREENS="YES"

# UTF-8 locale
# Fix for tmux adding space after zsh prompt
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Source additional config files
source ~/.zprompt
zstyle :compinstall filename '~/.zshrc'

setopt incappendhistory autocd extendedglob notify hist_ignore_dups
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

if [ -d ~/.zsh/zsh-autosuggestions ]; then
    source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
else
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi

## Aliases
alias ccat="highlight --out-format=ansi"
alias du="dust"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias fuck='sudo $(history -p \!\!)'
alias egrep='egrep --color=auto'
alias ls='ls -AFhN --color --group-directories-first'

# Use neovim instead of vim if present
command -v nvim >/dev/null && alias vim="nvim" vimdiff="nvim -d"

# Environment
export BROWSER="firefox"
export EDITOR="nvim"
export READER="zathura"
export SUDO_ASKPASS="$HOME/bin/dmenupass"
export TERMINAL="st"
#export VISUAL="nvim-qt"

# less/man colors
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '\e[1;31m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '\e[1;36m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '\e[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '\e[01;44;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '\e[0m')"; a="${a%_}"
export LESS_TERMCAP_us="$(printf '%b' '\e[01;32m')"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf '%b' '\e[0m')"; a="${a%_}"

# PATH
export PATH="$PATH:$HOME/.cargo/bin"

source /usr/share/nvm/init-nvm.sh # Set up NVM
#source "/etc/profile.d/rvm.sh" # Set up RVM

