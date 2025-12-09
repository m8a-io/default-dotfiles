#!/bin/sh
set -e

echo ">> Installing DevOps Toolbox Setup..."

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"

# Ensure Zsh/OMZ standard setup first (assumes user wants Zsh base)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo ">> Installing Oh My Zsh (prerequisite)..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

mv "$HOME/.zshrc" "$HOME/.zshrc.bak" 2>/dev/null || true
ln -sf "$REPO_ROOT/.zshrc" "$HOME/.zshrc"

echo ">> DevOps configs linked."

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
