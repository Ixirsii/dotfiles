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

# Tmux
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

## Aliases
alias ccat="highlight --out-format=ansi"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias fuck='sudo $(history -p \!\!)'
alias egrep='egrep --color=auto'
alias ls='gls -AFhlN --color --group-directories-first'

# Use neovim instead of vim if present
command -v nvim >/dev/null && alias vim="nvim" vimdiff="nvim -d"

# Environment
export BROWSER="safari"
export EDITOR="nvim"
export TERMINAL="alacritty"

# AEXP Proxy
export http_proxy=http://proxy.aexp.com:8080
export https_proxy=http://proxy.aexp.com:8080
export HTTPS_PROXY=http://proxy.aexp.com:8080
export HTTP_PROXY=http://proxy.aexp.com:8080
export NO_PROXY=.aexp.com,localhost

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
export PATH="$PATH:/opt/homebrew/bin"
export PATH="$PATH:$HOME/.cargo/bin"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Plugins
# https://github.com/MichaelAquilina/zsh-auto-notify
source ~/.config/zsh/zsh-auto-notify/auto-notify.plugin.zsh
# https://github.com/zsh-users/zsh-autosuggestions
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# https://github.com/zsh-users/zsh-history-substring-search
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
# https://github.com/zsh-users/zsh-syntax-highlighting
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# https://github.com/MichaelAquilina/zsh-you-should-use
source ~/.config/zsh/zsh-you-should-use/zsh-you-should-use.plugin.zsh

