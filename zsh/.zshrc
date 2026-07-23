typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
ZSH_CUSTOM="$HOME/dotfiles/zsh/oh-my-zsh-custom"
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
alias connect-ubuntu='ssh ethansev@ethanubuntu'

plugins=(git)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# >>> railway initialize >>>
[[ ! -f "$HOME/.railway/env" ]] || source "$HOME/.railway/env"
# <<< railway initialize <<<

[[ ! -f "$HOME/.cargo/env" ]] || . "$HOME/.cargo/env"

# Stamp image(s) with iPhone 17 Pro Max screenshot-style EXIF, captured "now".
# Usage: iphone-fixture [--out DIR] [--no-rename] FILE [FILE ...]
iphone-fixture() {
  ~/Code/make-iphone-fixture.sh \
    --model "iPhone 17 Pro Max" \
    --software "26.5" \
    --date "$(date +'%Y:%m:%d %H:%M:%S')" \
    --tz "$(date +%z | sed -E 's/(..)$/:\1/')" \
    --no-rename \
    "$@"
}

# API keys and other secrets live in secrets.zsh (gitignored via *secret*)
[[ ! -f ~/dotfiles/zsh/secrets.zsh ]] || source ~/dotfiles/zsh/secrets.zsh
