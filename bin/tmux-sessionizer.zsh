#!/bin/zsh

DEV_DIR="$HOME/dev"

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/dev -mindepth 1 -maxdepth 3 -type d -name ".git" | 
        sed -e 's:/\.git$::' -e "s:^$HOME/dev/::" | fzf-tmux)

    # catch escape key
    if [[ $? -eq 130 ]]; then
        exit 1
    fi
    selected=$DEV_DIR/$selected
fi

if [[ -z $selected ]]; then
    exit 0
fi

session_name=$(basename "$selected" | sed 's/\./_/g')

tmux_running=$(pgrep tmux)
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $session_name -c $selected 
    exit 0
fi

if ! tmux has-session -t=$session_name 2> /dev/null; then
    tmux new-session -ds $session_name -c $selected
fi

tmux switch-client -t $session_name
