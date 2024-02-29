# general settings
export ZSH=$(readlink -f $HOME/.config/zsh)
export HISTFILE=$ZSH/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
export PATH="$PATH:$HOME/.local/bin/"

# theme
source $ZSH/themes/dracula/dracula.zsh-theme

# plugins
source $ZSH/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
zstyle ':completion:*:*:git:*' script $ZSH/plugins/git-completions/git-completion.bash
fpath=($ZSH/plugins/zsh-completions/src $ZSH/plugins/git-completions $fpath)
autoload -Uz compinit && compinit

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# golang
export PATH=$PATH:$(go env GOPATH)/bin
#
# pnpm
export PNPM_HOME="/Users/dormunis/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# tmux
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# aliases
source $ZSH/aliases/customized.plugin.zsh
source $ZSH/aliases/kubectl.plugin.zsh
bindkey -s '^f' "tmux-sessionizer\n"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dormunis/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/dormunis/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dormunis/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/dormunis/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

KUBE_EDITOR=nvim
