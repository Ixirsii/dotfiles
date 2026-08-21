export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# Start tmux
if (( $+commands[tmux] )) && [[ -n $TTY && -z $TMUX ]]; then
  exec tmux new-session -A -s main
fi
