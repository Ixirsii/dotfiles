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
[ -f "$HOME/.config/zsh/os.zsh" ] && source "$HOME/.config/zsh/os.zsh"

eval "$(atuin init zsh)"
eval "$(fnm env --use-on-cd)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# pnpm
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac

# SDKMAN
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
