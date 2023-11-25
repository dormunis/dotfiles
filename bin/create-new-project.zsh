#!/bin/zsh

# Function to display help message
show_help() {
    echo "Usage: create_project.sh [OPTIONS]"
    echo "Create a new project in the DEV_FOLDER directory."
    echo ""
    echo "Options:"
    echo "  -h, --help    Display this help message and exit."
    echo "  -n, --no-tmux Create the project but don't start a Tmux session."
    exit 0
}

verify_exit_code() {
    if [ $? -ne 0 ]; then
        exit 1
    fi
}

# Initialize flags
NO_TMUX=0
DEV_FOLDER="$HOME/dev"

# Parse command line options
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            show_help
            ;;
        -n|--no-tmux)
            NO_TMUX=1
            ;;
        -*)
            echo "Unknown option: $1"
            show_help
            ;;
        *)
            if [ -z "$DIR" ]; then
                DIR="$1"
            elif [ -z "$NAME" ]; then
                NAME="$1"
            else
                echo "Unexpected argument: $1"
                show_help
            fi
            ;;
    esac
    shift
done

# Get project location 
if [ -z "$DIR" ]; then
    DIRS=`find "$DEV_FOLDER" -type d -mindepth 1 -maxdepth 1 -exec basename {} \;`
    DIR=`echo $DIRS | fzf --header "New project location"`
    verify_exit_code
fi

if [ ! -d "$DEV_FOLDER/$DIR" ]; then
    echo "Invalid project location"
    exit 1
fi

if [ -z "$NAME" ]; then
    vared -p $'\e[1;33mEnter new project name\e[0m '"($HOME/$DIR): " -c NAME
    verify_exit_code
fi

# Check if project already exists
NEW_PROJECT="$DEV_FOLDER/$DIR/$NAME"
if [[ -d $NEW_PROJECT ]]; then
    echo "Project $NEW_PROJECT already exists"
else
    echo "Creating project $NEW_PROJECT"
    mkdir -p $NEW_PROJECT
    git init $NEW_PROJECT > /dev/null
fi

# Move to project folder
if [ $NO_TMUX -eq 0 ]; then
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
fi
