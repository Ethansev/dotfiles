#!/bin/bash
# Dotfiles Installation Script
# Symlinks dotfiles to home directory

set -e

DOTFILES="$HOME/dotfiles"

echo "Installing dotfiles from $DOTFILES"

# Create backup directory
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

backup_if_exists() {
    local file="$1"
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        mkdir -p "$BACKUP_DIR"
        echo "Backing up $file to $BACKUP_DIR/"
        mv "$file" "$BACKUP_DIR/"
    elif [ -L "$file" ]; then
        rm "$file"
    fi
}

# Install Oh-My-Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Powerlevel10k if not present
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
fi

# Zsh
echo "Linking Zsh configs..."
backup_if_exists "$HOME/.zshrc"
backup_if_exists "$HOME/.zprofile"
backup_if_exists "$HOME/.zshenv"
backup_if_exists "$HOME/.p10k.zsh"
ln -sf "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/zsh/.zprofile" "$HOME/.zprofile"
ln -sf "$DOTFILES/zsh/.zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES/zsh/.p10k.zsh" "$HOME/.p10k.zsh"

# Oh-My-Zsh custom files (excluding themes since p10k is installed separately)
echo "Linking Oh-My-Zsh custom files..."
if [ -d "$DOTFILES/zsh/oh-my-zsh-custom" ]; then
    # Link custom plugins
    if [ -d "$DOTFILES/zsh/oh-my-zsh-custom/plugins" ]; then
        for plugin in "$DOTFILES/zsh/oh-my-zsh-custom/plugins"/*; do
            if [ -d "$plugin" ]; then
                plugin_name=$(basename "$plugin")
                target="$HOME/.oh-my-zsh/custom/plugins/$plugin_name"
                backup_if_exists "$target"
                ln -sf "$plugin" "$target"
            fi
        done
    fi
    # Link custom .zsh files
    for zshfile in "$DOTFILES/zsh/oh-my-zsh-custom"/*.zsh; do
        if [ -f "$zshfile" ]; then
            filename=$(basename "$zshfile")
            target="$HOME/.oh-my-zsh/custom/$filename"
            backup_if_exists "$target"
            ln -sf "$zshfile" "$target"
        fi
    done
fi

# Tmux
echo "Linking Tmux config..."
backup_if_exists "$HOME/.tmux.conf"
ln -sf "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Install TPM if not present
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing Tmux Plugin Manager (TPM)..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# Install tmux plugins via TPM
echo "Installing tmux plugins..."
tmux start-server \; set-environment -g TMUX_PLUGIN_MANAGER_PATH "$HOME/.tmux/plugins" 2>/dev/null || true
"$HOME/.tmux/plugins/tpm/bin/install_plugins"

# Tmuxinator
echo "Linking Tmuxinator configs..."
mkdir -p "$HOME/.config"
backup_if_exists "$HOME/.config/tmuxinator"
ln -sf "$DOTFILES/tmuxinator" "$HOME/.config/tmuxinator"

# Git
echo "Linking Git config..."
backup_if_exists "$HOME/.gitconfig"
ln -sf "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"

# Neovim binary + LazyVim runtime deps
if ! command -v nvim >/dev/null 2>&1; then
    echo "Installing Neovim and LazyVim dependencies..."
    sudo apt-get update
    sudo apt-get install -y neovim ripgrep fd-find build-essential unzip curl
fi

# LazyVim expects `fd`, but Ubuntu's package installs it as `fdfind`
if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
    mkdir -p "$HOME/.local/bin"
    ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
fi

# Neovim
echo "Linking Neovim config..."
mkdir -p "$HOME/.config"
backup_if_exists "$HOME/.config/nvim"
ln -sf "$DOTFILES/nvim" "$HOME/.config/nvim"

# Claude
echo "Linking Claude config..."
mkdir -p "$HOME/.claude"
backup_if_exists "$HOME/.claude/settings.json"
ln -sf "$DOTFILES/claude/settings.json" "$HOME/.claude/settings.json"
if [ -d "$DOTFILES/claude/commands" ]; then
    backup_if_exists "$HOME/.claude/commands"
    ln -sf "$DOTFILES/claude/commands" "$HOME/.claude/commands"
fi

echo ""
echo "Dotfiles installed successfully!"
if [ -d "$BACKUP_DIR" ]; then
    echo "Backups saved to: $BACKUP_DIR"
fi
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Re-authenticate GitHub CLI: gh auth login"
echo "  3. Set up iTerm2 sync: Preferences > General > Settings > Load from ~/dotfiles/iterm2"
