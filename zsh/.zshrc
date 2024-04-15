# use this for profiling in case the shell becomes slow
export PROFILING_MODE=0
if [ $PROFILING_MODE -ne 0 ]; then
    zmodload zsh/zprof
fi

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

# golang
export PATH=$PATH:$(go env GOPATH)/bin

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
source $ZSH/aliases/git.plugin.zsh
export KUBE_EDITOR=nvim
bindkey -s '^f' "tmux-sessionizer\n"

# nvm
export NVM_DIR="$HOME/.nvm"

nvm_lazy_cmd=(nvm node npm npx pnpm yarn $nvm_lazy_cmd)
eval "
function $nvm_lazy_cmd {
    for func in $nvm_lazy_cmd; do
    if (( \$+functions[\$func] )); then
        unfunction \$func
    fi
    done
    # Load nvm if it exists in \$NVM_DIR
    [[ -f \"\$NVM_DIR/nvm.sh\" ]] && source \"\$NVM_DIR/nvm.sh\"
    \"\$0\" \"\$@\"
}
"
unset nvm_lazy_cmd
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if [ $PROFILING_MODE -ne 0 ]; then
    zprof
fi
