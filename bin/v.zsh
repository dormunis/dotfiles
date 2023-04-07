#!/bin/zsh

# Function for opening the file in the appropriate context
open_file_in_context() {
    file_path="$1"
    containing_directory=$(dirname "$file_path")
    git_repo_path=$(git -C "$containing_directory" rev-parse --show-toplevel 2>/dev/null)

    if [[ -n $git_repo_path ]]; then
        target_session=$(tmux-sessionizer "$git_repo_path")
    else
        target_session=$(tmux-sessionizer "$containing_directory")
    fi

    tmux switch-client -t "$target_session"

    working_dir=$(tmux display-message -p -F "#{pane_current_path}" -t "$target_session")
    cwd=$(tmux display-message -p -F "#{pane_current_path}")
    abs_file_path="$cwd/$file_path"
    relative_path=${abs_file_path#${working_dir}/}

    tmux send-keys -t "$target_session" "nvim '$relative_path'" Enter
}

if [[ $# -eq 1 ]]; then
    search_query=$1
elif [[ $# -gt 1 ]]; then
    echo "Error: Only one argument is allowed"
    exit -1
fi

selected_file=$(fd --type f --hidden --exclude .git | fzf-tmux -p --reverse --query "$search_query")
[[ -n $selected_file ]] && open_file_in_context "$selected_file"

