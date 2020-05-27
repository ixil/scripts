#!/bin/bash
# me="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
me="${0##*/}"
# echo ME: $me
COMMAND="$@"
if [ $me == 'gnome-terminal' ]; then
    COMMAND="${@:2}"
fi

# Prefix
#  -- gdb -ex run --args"

NAME_OF_SESSION="launches"
if ! tmux has-session -t $NAME_OF_SESSION; then
    echo "create session: $NAME_OF_SESSION"
    tmux new-session -dt $NAME_OF_SESSION
fi
WINDOW_OF_SESSION=$(tmux list-windows -t ${NAME_OF_SESSION} | awk '{ print $1  }' )
WINDOW_OF_SESSION="${WINDOW_OF_SESSION%:}"
tmux switch-client -t "$NAME_OF_SESSION"
WINDOW_REF="${NAME_OF_SESSION}:${WINDOW_OF_SESSION}"

# if [ ! $(tmux last-window -t "$NAME_OF_SESSION") ]; then
tmux select-window -t $WINDOW_REF
# fi
# Keep executable shell
tmux set-window-option -t ${NAME_OF_SESSION} remain-on-exit on
tmux split-window -d -t "${NAME_OF_SESSION}:${WINDOW_OF_SESSION}" "$COMMAND"
# tmux split-window -d -t "$WINDOW_REF" "$COMMAND"
tmux select-layout main-horizontal
