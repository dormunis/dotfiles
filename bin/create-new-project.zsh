#!/bin/zsh

# Create new project folder and git repo
DEV_FOLDER="$HOME/dev"
DIRS=`find "$DEV_FOLDER" -type d -mindepth 1 -maxdepth 1 -exec basename {} \;`
DIR=`echo $DIRS | fzf --header "New project location"`
vared -p $'\e[1;33mEnter new project name\e[0m '"($HOME/$DIR): " -c NAME
NEW_PROJECT="$DEV_FOLDER/$DIR/$NAME"

# Check if project already exists
if [[ -d $NEW_PROJECT ]]; then
    echo "Project $NEW_PROJECT already exists"
else
    echo "Creating project $NEW_PROJECT"
    mkdir -p $NEW_PROJECT
    git init $NEW_PROJECT > /dev/null
fi

# Move to project folder
tmux_running=$(pgrep tmux)
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $DIR -c $NEW_PROJECT -n $NAME
    exit 0
fi

if ! tmux has-session -t=$DIR 2> /dev/null; then
    tmux new-session -ds $DIR -c $NEW_PROJECT -n $NAME
fi

window_exists=$(tmux list-windows -t "$DIR" -F '#{window_name}' | grep -Fx "$NAME")
if [[ -z $window_exists ]]; then
    next_index=$(tmux list-windows -t $DIR -F '#{window_index}' | awk 'BEGIN{max=-1}{if($1>max) max=$1}END{print max+1}')
    tmux new-window -c $NEW_PROJECT -n $NAME -t $DIR:$next_index
fi

tmux switch-client -t $DIR:$NAME
