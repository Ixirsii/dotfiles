# Environment
set -gx BROWSER Helium
set -gx EDITOR nvim
set -gx TERMINAL wezterm

# Set bat theme
set -gx BAT_THEME "Catppuccin Mocha"

# Source /etc/profile
fish_add_path -p /etc/profile

# Wezterm CLI support
fish_add_path -a "/Applications/WezTerm.app/Contents/MacOS"

if status is-interactive
    # Atuin
    atuin init fish | source

    # FNM
    fnm env --use-on-cd --shell fish | source

    # Zoxide
    zoxide init fish | source

    # Starship
    starship init fish | source
end

function fish_title
    set -f cwd (prompt_pwd | string split /)[-1]
    set -q argv[1]; or set argv fish

    if set -q argv[1]; and [ $argv[1] != fish ]
        echo $argv[1] $cwd
    else
        echo $cwd
    end
end
