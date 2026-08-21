# Start tmux
if (( $+commands[tmux] )) && [[ -n $TTY && -z $TMUX ]]; then
  exec tmux new-session -A -s main
fi
