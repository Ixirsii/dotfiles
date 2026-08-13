# Start tmux
if [[ -x "$(command -v tmux)" && -n "$TTY" && -z "$TMUX" ]]
then
  exec tmux new-session -A
fi

