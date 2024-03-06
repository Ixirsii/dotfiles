# If not running interactively, do not do anything
[[ $- != *i* ]] && return

# ############################################################################ #
#                                    PROMPT                                    #
# ############################################################################ #

bash_prompt_command() {
    # How many characters of the $PWD should be kept
    local pwdmaxlen25

    # Indicate that there has been dir truncation
    local trunc_symbol=".."

    # Store local dir
    local dir=${PWD##*/}
    
    # Which length to use
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))

    NEW_PWD=${PWD/#$HOME/\~}

    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))

    # Generate name
    if [ ${pwdoffset} -gt "0" ]
    then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
}

format_font() {
    local output=$1

    case $# in
    2)
        eval $output="'\[\033[0;${2}m\]'"
        ;;
    3)
        eval $output="'\[\033[0;${2};${3}m\]'"
        ;;
    4)
        eval $output="'\[\033[0;${2};${3};${4}m\]'"
        ;;
    *)
        eval $output="'\[\033[0m\]'"
        ;;
    esac
}

bash_prompt() {
    # Color constants for prompt
    ## Font effect
    local      NONE='0'
    local      BOLD='1'
    local       DIM='2'
    local UNDERLINE='4'
    local     BLINK='5'
    local    INVERT='7'
    local    HIDDEN='8'
     
    ## Colors
    local   DEFAULT='9'
    local     BLACK='0'
    local       RED='1'
    local     GREEN='2'
    local    YELLOW='3'
    local      BLUE='4'
    local   MAGENTA='5'
    local      CYAN='6'
    local    L_GRAY='7'
    local    D_GRAY='60'
    local     L_RED='61'
    local   L_GREEN='62'
    local  L_YELLOW='63'
    local    L_BLUE='64'
    local L_MAGENTA='65'
    local    L_CYAN='66'
    local     WHITE='67'
     
    ## TYPE
    local     RESET='0'
    local    EFFECT='0'
    local     COLOR='30'
    local        BG='40'
     
    # ########################## Configure here ########################## #
     
    local FONT_COLOR_1=$WHITE
    local BACKGROUND_1=$BLACK
    local TEXTEFFECT_1=$BOLD
     
    local FONT_COLOR_2=$WHITE
    local BACKGROUND_2=$D_GRAY
    local TEXTEFFECT_2=$BOLD
     
    local FONT_COLOR_3=$D_GRAY
    local BACKGROUND_3=$L_GRAY
    local TEXTEFFECT_3=$BOLD
     
    local PROMPT_FORMAT=$BLUE_BOLD

    # Convert codes: add offset
    FC1=$(($FONT_COLOR_1+$COLOR))
    BG1=$(($BACKGROUND_1+$BG))
    FE1=$(($TEXTEFFECT_1+$EFFECT))
     
    FC2=$(($FONT_COLOR_2+$COLOR))
    BG2=$(($BACKGROUND_2+$BG))
    FE2=$(($TEXTEFFECT_2+$EFFECT))
     
    FC3=$(($FONT_COLOR_3+$COLOR))
    BG3=$(($BACKGROUND_3+$BG))
    FE3=$(($TEXTEFFECT_3+$EFFECT))
     
    FC4=$(($FONT_COLOR_4+$COLOR))
    BG4=$(($BACKGROUND_4+$BG))
    FE4=$(($TEXTEFFECT_4+$EFFECT))
     

    # Call formatting helper function: effect + font color + BG color
    local TEXT_FORMAT_1
    local TEXT_FORMAT_2
    local TEXT_FORMAT_3
    local TEXT_FORMAT_4 
    format_font TEXT_FORMAT_1 $FE1 $FC1 $BG1
    format_font TEXT_FORMAT_2 $FE2 $FC2 $BG2
    format_font TEXT_FORMAT_3 $FC3 $FE3 $BG3
    format_font TEXT_FORMAT_4 $FC4 $FE4 $BG4
     
    # Generate prompt sections
    local PROMPT_USER=$"$TEXT_FORMAT_1 \u "
    local PROMPT_HOST=$"$TEXT_FORMAT_2 \h "
    local PROMPT_PWD=$"$TEXT_FORMAT_3 \${NEW_PWD} "
    local PROMPT_INPUT=$"$PROMPT_FORMAT "

    ## Convert codes
    TSFC1=$(($BACKGROUND_1+$COLOR))
    TSBG1=$(($BACKGROUND_2+$BG))
     
    TSFC2=$(($BACKGROUND_2+$COLOR))
    TSBG2=$(($BACKGROUND_3+$BG))
     
    TSFC3=$(($BACKGROUND_3+$COLOR))
    TSBG3=$(($DEFAULT+$BG))

    ## Call formatting helper function: effect + font color + BG color
    local SEPARATOR_FORMAT_1
    local SEPARATOR_FORMAT_2
    local SEPARATOR_FORMAT_3
    format_font SEPARATOR_FORMAT_1 $TSFC1 $TSBG1
    format_font SEPARATOR_FORMAT_2 $TSFC2 $TSBG2
    format_font SEPARATOR_FORMAT_3 $TSFC3 $TSBG3

    # Generate separators with semi-circle
    local TRIANGLE=$'\uE0B0' 
    local SEPARATOR_1=$SEPARATOR_FORMAT_1$TRIANGLE
    local SEPARATOR_2=$SEPARATOR_FORMAT_2$TRIANGLE
    local SEPARATOR_3=$SEPARATOR_FORMAT_3$TRIANGLE

    case $TERM in
    xterm*|rxvt*)
        local TITLEBAR='\[\033]0;\u:${NEW_PWD}\007\]'
        ;;
    *)
        local TITLEBAR=""
        ;;
    esac

    PS1="$TITLEBAR\n${PROMPT_USER}${SEPARATOR_1}${PROMPT_HOST}${SEPARATOR_2}${PROMPT_PWD}${SEPARATOR_3}${PROMPT_INPUT}"

    ## For terminal line coloring, leaving the rest standard
    none="$(tput sgr0)"
    trap 'echo -ne "${none}"' DEBUG
}


# Bash provides an environment variable called PROMPT_COMMAND. 
# The contents of this variable are executed as a regular Bash command 
# just before Bash displays a prompt. 
# We want it to call our own command to truncate PWD and store it in NEW_PWD
PROMPT_COMMAND=bash_prompt_command

# Call bash_promnt only once, then unset it (not needed any more)
# It will set $PS1 with colors and relative to $NEW_PWD, 
# which gets updated by $PROMPT_COMMAND on behalf of the terminal
bash_prompt
unset bash_prompt

# ############################################################################ #
#                                 ENVIRONMENT                                  #
# ############################################################################ #

## Aliases
alias ccat="highlight --out-format=ansi"
alias du="dust"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias fuck='sudo $(history -p \!\!)'
alias egrep='egrep --color=auto'
alias ls='ls -AFhlN --color --group-directories-first'

# Use neovim instead of vim if present
command -v nvim >/dev/null && alias vim="nvim" vimdiff="nvim -d"

# Environment
export BROWSER="safari"
export EDITOR="nvim"
export TERMINAL="alacritty"

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

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

