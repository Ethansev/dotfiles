# Dotfiles

Personal dotfiles for macOS.

## What's Included

| Config | Description |
|--------|-------------|
| **Zsh** | Shell configuration with Oh-My-Zsh and Powerlevel10k |
| **Tmux** | Terminal multiplexer config |
| **Tmuxinator** | Tmux session layouts |
| **Git** | Git configuration |
| **Claude** | Claude Code CLI settings |
| **Neovim** | LazyVim config (Harpoon, Catppuccin, tmux navigator) |
| **iTerm2** | Placeholder for iTerm2 preferences sync |

## Installation

### On a New Machine

```bash
# Clone this repo
git clone https://github.com/Ethansev/dotfiles.git ~/dotfiles

# Run the install script
cd ~/dotfiles && ./install.sh
```

The install script will:
- Install Oh-My-Zsh (if not present)
- Install Powerlevel10k theme (if not present)
- Install TPM (Tmux Plugin Manager) and tmux plugins (if not present)
- Symlink all config files to their correct locations
- Back up any existing configs to `~/.dotfiles-backup-<timestamp>/`

### Post-Installation

1. **Restart your terminal** or run `source ~/.zshrc`

2. **Re-authenticate GitHub CLI:**
   ```bash
   gh auth login
   ```

3. **Set up iTerm2 sync:**
   - Open iTerm2 > Preferences > General > Settings
   - Check "Load preferences from a custom folder"
   - Set folder to `~/dotfiles/iterm2`
   - Check "Save changes automatically"

4. **Update tmux plugins** (when you change `.tmux.conf` plugins):
   - Inside tmux, press `prefix + I` to install/update plugins

5. **Neovim** — launch `nvim`; lazy.nvim bootstraps on first run. Wait for `:Lazy sync` to finish.

## Dependencies

These are installed automatically by `install.sh` or should be installed manually:

- [Oh-My-Zsh](https://ohmyz.sh/) - Zsh framework
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) - Zsh theme
- [TPM](https://github.com/tmux-plugins/tpm) - Tmux Plugin Manager (installed automatically)
- [Tmux](https://github.com/tmux/tmux) - `brew install tmux`
- [Tmuxinator](https://github.com/tmuxinator/tmuxinator) - `gem install tmuxinator`
- [GitHub CLI](https://cli.github.com/) - `brew install gh`
- [Claude Code](https://claude.ai/claude-code) - `npm install -g @anthropic-ai/claude-code`

## Excluded (Contains Secrets)

These are not tracked and need to be set up manually on new machines:

- `~/.config/gh/` - Run `gh auth login`
- `~/.claude.json` - Contains authentication tokens

## Structure

```
dotfiles/
├── zsh/
│   ├── .zshrc
│   ├── .zprofile
│   ├── .zshenv
│   ├── .p10k.zsh
│   └── oh-my-zsh-custom/
├── tmux/
│   └── .tmux.conf
├── tmuxinator/
│   └── *.yml
├── git/
│   └── .gitconfig
├── claude/
│   └── settings.json
├── nvim/
│   ├── init.lua
│   ├── lazyvim.json
│   └── lua/{config,plugins}/
├── iterm2/
├── install.sh
└── README.md
```
