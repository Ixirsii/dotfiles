# Configure fnm
fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression

# Enable starship
Invoke-Expression (&starship init powershell)
