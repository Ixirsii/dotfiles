# PATH
export PATH="$PATH:$HOME/.cargo/bin"

# Environment
export BROWSER="zen"
export EDITOR="nvim"
export TERMINAL="ghostty"

# Start tmux
local tmux_session_name="ryan"

if [[ -n "$TTY" && -z "$TMUX" ]]
then
  exec tmux new-session -A -s $tmux_session_name
fi

# Zsh options (https://zsh.sourceforge.io/Doc/Release/Options.html)
setopt incappendhistory extendedglob hist_ignore_dups
unsetopt beep nomatch

# Save history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

# Aliases
alias cat="bat"
alias cd="z"
alias ls="eza -A --color=always --header --long --git --group-directories-first --icons=always"
alias vim="nvim"
alias vimdiff="nvim -d"

# Start atuin
eval "$(atuin init zsh)"

# Set bat theme
export BAT_THEME="Catppuccin Mocha"

# FNM
eval "$(fnm env --use-on-cd)"

# Zoxide (better cd)
eval "$(zoxide init zsh)"

# Set GPG_TTY so that git commits work from the terminal
export GPG_TTY=$TTY

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

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Start starship
eval "$(starship init zsh)"
