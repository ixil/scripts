#!/bin/bash

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
# tmux split-window -d -t "${NAME_OF_SESSION}:${WINDOW_OF_SESSION}" "$*; zsh"
tmux set-window-option -t ${NAME_OF_SESSION} remain-on-exit on
tmux select-layout main-horizontal
tmux split-window -d -t "$WINDOW_REF" "$*"
