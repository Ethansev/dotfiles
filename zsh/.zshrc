# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# /etc/zprofile (which runs path_helper to build the system PATH) only fires
# for login shells. Non-login shells like tmux panes skip it and lose
# /usr/local/bin, /usr/sbin, /sbin, etc. Re-invoke path_helper here so PATH is
# correct everywhere. typeset -U keeps PATH free of duplicates.
if [[ -x /usr/libexec/path_helper ]]; then
  eval "$(/usr/libexec/path_helper -s)"
fi
typeset -U path PATH

ZSH_THEME="powerlevel10k/powerlevel10k"

export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"

# aliases
github() {
    if [[ -n "$1" ]]; then
        cd ~/Code/Github/"$1"
    else
        cd ~/Code/Github
    fi
}

alias mux=tmuxinator

plugins=(git)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
