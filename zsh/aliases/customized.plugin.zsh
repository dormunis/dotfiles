alias ls="ls -h --color=auto"
alias ll="ls -lah"
alias vim=nvim
alias aliases="vim $ZSH/aliases/customized.plugin.zsh"
alias v="fd --type f --hidden --exclude .git | fzf-tmux -p --reverse | xargs nvim"
