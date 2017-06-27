# If not running interactively, do not do anything
[[ $- != *i* ]] && return

default="\[\033[0m\]"
black="\[\033[30m\]"
red="\[\033[31m\]"
green="\[\033[32m\]"
yellow="\[\033[33m\]"
blue="\[\033[34m\]"
magenta="\[\033[35m\]"
cyan="\[\033[36m\]"
grey="\[\033[37m\]"

dark_grey="\[\033[90m\]"
light_red="\[\033[91m\]"
light_green="\[\033[92m\]"
light_yellow="\[\033[93m\]"
light_blue="\[\033[94m\]"
light_magenta="\[\033[95m\]"
light_cyan="\[\033[96m\]"
white="\[\033[97m\]"

export PS1="$white[$cyan\u$white@$cyan\h$white] $cyan\w $green\$\[$(tput sgr0)\] "

tmux_session_name="ryan"

# TMUX
if which tmux >/dev/null 2>&1; then
    #if not inside a tmux session, and if no session is started, start a new session
    if (tmux has -t $tmux_session_name); then
        tmux -2 new-session -d -s $tmux_session_name
    fi

    if test -z "$TMUX"; then
        (tmux new-session -t $tmux_session_name)
    fi
fi

alias ls='ls --color=auto'

alias bb='brazil-build'
alias bba='brazil-build apollo-pkg'
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


export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
export PATH=$BRAZIL_CLI_BIN:$PATH
