function ls --wraps='eza -A --color=always --header --long --git --icons=always' --wraps='eza -Ag --color=always --header --long --git --icons=always' --description 'alias ls eza -Ag --color=always --header --long --git --icons=always'
    eza -Ag --color=always --header --long --git --icons=always $argv
end
