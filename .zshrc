# PATH
export PATH="$PATH:/opt/homebrew/bin"
export PATH="$PATH:$HOME/.cargo/bin"

# Environment
export BROWSER="Zen"
export EDITOR="nvim"
export TERMINAL="Ghostty"

# Start tmux
local tmux_session_name="ryan"

if [ $tty -s -a -z "$TMUX" ]; then
  exec tmux new-session -A -s $tmux_session_name
fi

# Zsh options (https://zsh.sourceforge.io/Doc/Release/Options.html)
setopt incappendhistory extendedglob hist_ignore_dups
unsetopt beep nomatch

# Save history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

# less/man colors
export LESS=-R
export LESS_TERMCAP_mb="$(printf "%b" "\e[1;31m")"; a="${a%_}"
export LESS_TERMCAP_md="$(printf "%b" "\e[1;36m")"; a="${a%_}"
export LESS_TERMCAP_me="$(printf "%b" "\e[0m")"; a="${a%_}"
export LESS_TERMCAP_so="$(printf "%b" "\e[01;44;33m")"; a="${a%_}"
export LESS_TERMCAP_se="$(printf "%b" "\e[0m")"; a="${a%_}"
export LESS_TERMCAP_us="$(printf "%b" "\e[01;32m")"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf "%b" "\e[0m")"; a="${a%_}"

# Plugins
# https://github.com/MichaelAquilina/zsh-auto-notify
source ~/.config/zsh/zsh-auto-notify/auto-notify.plugin.zsh
# https://github.com/zsh-users/zsh-autosuggestions
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# https://github.com/zsh-users/zsh-history-substring-search
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
# https://github.com/catppuccin/zsh-syntax-highlighting.git
source ~/.config/zsh/catppuccin/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
# https://github.com/zsh-users/zsh-syntax-highlighting
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# https://github.com/MichaelAquilina/zsh-you-should-use
source ~/.config/zsh/zsh-you-should-use/zsh-you-should-use.plugin.zsh

# FZF
eval "$(fzf --zsh)"
source ~/fzf-git.sh/fzf-git.sh
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Use fd instead of fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview "eza --tree --color=always {} | head -200" "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview "dig {}"                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Set bat theme
export BAT_THEME="Catppuccin Mocha"

# thefuck alias
eval "$(thefuck --alias)"

# Zoxide (better cd)
eval "$(zoxide init zsh)"

# Set GPG_TTY so that git commits work from the terminal
export GPG_TTY=$TTY

# FNM
eval "$(fnm env --use-on-cd)"

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Aliases
# These must be after sdkman init because the find alias breaks sdkman scripts
alias cat="bat"
alias cd="z"
alias find="fd"
alias grep="rg --color=always"
alias ls="eza -A --color=always --header --long --git --icons=always"
alias vim="nvim"
alias vimdiff="nvim -d"

# Start starship
eval "$(starship init zsh)"
