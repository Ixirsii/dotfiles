source /apollo/env/envImprovement/var/zshrc
source ~/.zprompt
zstyle :compinstall filename '/home/ryan/.zshrc'

setopt appendhistory autocd extendedglob notify hist_ignore_dups
unsetopt beep nomatch
bindkey -v

autoload -Uz compinit
compinit

tmux_session_name="ryan"

#if which tmux >/dev/null 2>&1; then
    #if not inside a tmux session, and if no session is started, start a new session
#    if (! tmux has-session -t $tmux_session_name); then
#        echo "starting tmux daemon session"
#        tmux -2 new-session -s $tmux_session_name -d
#    fi
#
#    if test -z "$TMUX"; then
#        (tmux new-session -t $tmux_session_name)
#    fi
#    
#fi

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

alias bb='brazil-build'
alias bba='brazil-build apollo-pkg'
alias bo='/apollo/env/OctaneBrazilTools/bin/brazil-octane'
alias bre='brazil-runtime-exec'
alias brc='brazil-recursive-cmd'
alias bws='brazil ws'
alias bwsuse='bws use --gitMode -p'
alias bwscreate='bws create -n'
alias brc='brazil-recursive-cmd'
alias bbr='brc brazil-build'
alias bball='brc --allPackages'
alias bbb='brc --allPackages brazil-build'
alias bbra='bbr apollo-pkg'
alias register_with_aaa='/apollo/env/AAAWorkspaceSupport/bin/register_with_aaa.py'

export EDITOR="vim"
export PATH="usr/local/bin:$PATH:$HOME/bin"
if which brew >/dev/null 2>&1; then
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
fi
export PATH="$BRAZIL_CLI_BIN:$PATH"
export SKIP_GIT_CHECK=1
