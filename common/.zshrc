# ############################################################################ #
#                                 Environment                                  #
# ############################################################################ #

export BAT_THEME="Catppuccin Mocha"
export BUN_INSTALL="$HOME/.bun"
export PNPM_HOME="$HOME/.local/share/pnpm"
export SDKMAN_DIR="$HOME/.sdkman"

export BROWSER="zen"
export EDITOR="nvim"
export PATH="$HOME/.local/bin:$PATH:$HOME/.cargo/bin:$BUN_INSTALL/bin"
export TERMINAL="wezterm"

# ############################################################################ #
#                                 Zsh options                                  #
# ############################################################################ #

autoload -Uz add-zsh-hook
setopt incappendhistory extendedglob hist_ignore_dups
unsetopt beep nomatch

# Title
DISABLE_AUTO_TITLE="true"

function precmd() {
    print -Pn "\e]2;%1~\a"
}

function preexec() {
    print -n -- "\e]2;${(q)1}\a"
}

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

# Plugins
# https://github.com/junegunn/fzf-git.sh
source ~/.config/zsh/fzf-git.sh/fzf-git.sh
# https://github.com/zsh-users/zsh-autosuggestions
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# https://github.com/catppuccin/zsh-syntax-highlighting.git
source ~/.config/zsh/catppuccin/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
# https://github.com/zsh-users/zsh-syntax-highlighting
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# https://github.com/MichaelAquilina/zsh-you-should-use
source ~/.config/zsh/zsh-you-should-use/zsh-you-should-use.plugin.zsh

# Aliases
alias cat="bat"
alias cd="z"
alias ls="eza -A --color=always --header --long --git --group-directories-first --icons=always"
alias vim="nvim"
alias vimdiff="nvim -d"

# ############################################################################ #
#                             Initialize programs                              #
# ############################################################################ #

# OS-specific setup
[ -s "$HOME/.config/zsh/os.zsh" ] && source "$HOME/.config/zsh/os.zsh"

# Go-installed commands
if (($+commands[go])); then
    go_bin="$(go env GOBIN)"
    [[ -n "$go_bin" ]] || go_bin="$(go env GOPATH)/bin"
    export PATH="$go_bin:$PATH"
    unset go_bin
fi

# Atuin
eval "$(atuin init zsh)"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Fast Node Manager
[ -x "$(command -v fnm)" ] && eval "$(fnm env --use-on-cd)"

# pnpm
case ":$PATH:" in
*":$PNPM_HOME/bin:"*) ;;
*) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac

# SDKMAN
[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Starship
eval "$(starship init zsh)"

# Zoxide
eval "$(zoxide init zsh)"

# ############################################################################ #
#                                    Hooks                                     #
# ############################################################################ #

function _set_idle_title() {
    print -Pn '\e]2;%1~\a'
}

function _set_command_title() {
    print -n -- $'\e]2;'"${(q)1}"$'\a'
}

add-zsh-hook precmd _set_idle_title
add-zsh-hook preexec _set_command_title
