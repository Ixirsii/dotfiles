# Start tmux
local tmux_session_name="ryan"

if [[ -n "$TTY" && -z "$TMUX" ]]
then
  exec tmux new-session -A -s $tmux_session_name
fi

