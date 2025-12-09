#!/bin/sh
set -e

echo ">> Installing Fish Shell setup..."

# Check for fish
if ! command -v fish > /dev/null || [ "$(fish --version | cut -d' ' -f3 | cut -d. -f1,2)" = "3.1" ]; then
    echo ">> Installing/Updating Fish (PPA)..."
    if command -v apt-get > /dev/null; then
        sudo apt-get update
        sudo apt-get install -y gnupg curl
        
        echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_11/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list
        curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_11/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null
        
        sudo apt-get update
        sudo apt-get install -y fish
    else
        echo ">> Error: Cannot install fish. Please install it manually."
        exit 1
    fi
fi

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$HOME/.config/fish"

mkdir -p "$CONFIG_DIR"

mv "$CONFIG_DIR/config.fish" "$CONFIG_DIR/config.fish.bak" 2>/dev/null || true
ln -sf "$REPO_ROOT/config.fish" "$CONFIG_DIR/config.fish"

# Set as default
CURRENT_SHELL=$(basename "$SHELL")
if [ "$CURRENT_SHELL" != "fish" ]; then
    echo ">> Changing default shell to fish..."
    if command -v sudo > /dev/null; then
        sudo chsh -s "$(which fish)" "$USER"
    else
        chsh -s "$(which fish)"
    fi
fi

echo ">> Fish setup complete."
