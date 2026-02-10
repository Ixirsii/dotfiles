# Environment
set -gx BROWSER Zen
set -gx EDITOR nvim
set -gx TERMINAL Ghostty

# Set bat theme
set -gx BAT_THEME "Catppuccin Mocha"

# FNM
fnm env --use-on-cd --shell fish | source

# Zoxide
zoxide init fish | source

# Aliases
alias cat="bat"
alias cd="z"
alias ls="eza -A --color=always --header --long --git --icons=always"
alias vim="nvim"
alias vimdiff="nvim -d"

if status is-interactive
    atuin init fish | source
    starship init fish | source
end
