#!/bin/zsh

DEV_DIR="$HOME/dev"

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/dev -mindepth 1 -maxdepth 5 -type d -name ".git" \
        -exec dirname {} \; \
        | perl -pe "s:^$HOME/dev/::" \
        | fzf-tmux --reverse -p)
    # catch escape key
    if [[ $? -eq 130 ]]; then
        exit 1
    fi
    selected=$DEV_DIR/$selected
fi

if [[ -z $selected ]]; then
    exit 0
fi

session_name=$(basename "$(dirname "$selected")")
selected_name=$(basename "$selected" | tr . _)

tmux_running=$(pgrep tmux)
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $session_name -c $selected -n $selected_name
    exit 0
fi

if ! tmux has-session -t=$session_name 2> /dev/null; then
    tmux new-session -ds $session_name -c $selected -n $selected_name
fi

window_exists=$(tmux list-windows -t "$session_name" -F '#{window_name}' | grep -Fx "$selected_name")
if [[ -z $window_exists ]]; then
    next_index=$(tmux list-windows -t $session_name -F '#{window_index}' | awk 'BEGIN{max=-1}{if($1>max) max=$1}END{print max+1}')
    tmux new-window -c $selected -n $selected_name -t $session_name:$next_index
fi

tmux switch-client -t $session_name:$selected_name
