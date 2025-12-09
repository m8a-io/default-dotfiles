#!/bin/sh
set -e

echo ">> Installing Minimal Bash setup..."

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"

mv "$HOME/.bashrc" "$HOME/.bashrc.bak" 2>/dev/null || true
ln -sf "$REPO_ROOT/.bashrc" "$HOME/.bashrc"

echo ">> Configuration linked."

# Set as default
CURRENT_SHELL=$(basename "$SHELL")
if [ "$CURRENT_SHELL" != "bash" ]; then
    echo ">> Changing default shell to bash..."
    if command -v sudo > /dev/null; then
        sudo chsh -s "$(which bash)" "$USER"
    else
        chsh -s "$(which bash)"
    fi
fi

echo ">> Please restart your shell or run 'bash'."
