#!/bin/zsh

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/dev -mindepth 1 -maxdepth 5 -type d -name ".git" -exec dirname {} \; | fzf-tmux --reverse -p)
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
    tmux new-window -t $session_name -c $selected -n $selected_name
fi

tmux switch-client -t $session_name:$selected_name
echo $session_name:$seleted_name
