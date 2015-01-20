source ~/.zprompt

# Lines configured by zsh-newuser-install
if ( tmux -q has-session -t ryan ); then
    tmux new-session -t ryan
fi

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob notify hist_ignore_dups
unsetopt beep nomatch
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ryan/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

## Aliases
alias arm='sudo -u tor arm'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color=auto'

export EDITOR="vim"
export JAVA_HOME=/usr/lib/jvm/java-default-runtime
export PATH=$PATH:"$HOME/bin:$HOME/perl5/bin"

# Weird PERL voodoo
export PERL5LIB="/home/ryan/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"
export PERL_LOCAL_LIB_ROOT="/home/ryan/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"
export PERL_MB_OPT="--install_base \"/home/ryan/perl5\""
export PERL_MM_OPT="INSTALL_BASE=/home/ryan/perl5"

# See if we can use extended characters to look nicer.
typeset -A altchar
set -A altchar ${(s..)terminfo[acsc]}
PR_SET_CHARSET="%{$terminfo[enacs]%}"
PR_SHIFT_IN="%{$terminfo[smacs]%}"
PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
PR_HBAR=${altchar[q]:--}

