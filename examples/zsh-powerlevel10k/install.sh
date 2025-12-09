#!/bin/sh
set -e

echo ">> Installing Powerlevel10k Setup..."

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    echo ">> Cloning Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
else
    echo ">> P10k already cloned."
fi

# Link .zshrc
mv "$HOME/.zshrc" "$HOME/.zshrc.bak" 2>/dev/null || true
ln -sf "$REPO_ROOT/.zshrc" "$HOME/.zshrc"

# Link .p10k.zsh (configuration)
mv "$HOME/.p10k.zsh" "$HOME/.p10k.zsh.bak" 2>/dev/null || true
ln -sf "$REPO_ROOT/.p10k.zsh" "$HOME/.p10k.zsh"

echo ">> Setup complete."

# Set as default
CURRENT_SHELL=$(getent passwd "$USER" | cut -d: -f7)
if [ "$(basename "$CURRENT_SHELL")" != "zsh" ]; then
    echo ">> Changing default shell to zsh..."
    if command -v sudo > /dev/null; then
        sudo chsh -s "$(which zsh)" "$USER"
    else
        chsh -s "$(which zsh)"
    fi
fi

echo ">> Please restart your shell."
