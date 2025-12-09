#!/bin/sh
set -e

echo ">> Installing Nix Home Manager Setup..."

# Check if nix is installed
if ! command -v nix > /dev/null; then
    echo ">> Nix not found. Installing (Single User Mode)..."
    # Try to install Nix in single-user mode (no daemon, better for containers)
    if command -v curl > /dev/null; then
        # Create destination directory if it doesn't exist (sometimes needed)
        # sudo mkdir -p /nix && sudo chown $USER /nix
        
        # Download install script to minimal temp file (POSIX compliant)
        curl -L https://nixos.org/nix/install -o /tmp/nix-install.sh
        sh /tmp/nix-install.sh --no-daemon --yes
        rm /tmp/nix-install.sh
        
        # Source nix profile to make it available immediately
        if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
            . "$HOME/.nix-profile/etc/profile.d/nix.sh"
        fi
    else
        echo ">> Error: curl is required to install Nix."
        exit 1
    fi
fi

# Check if home-manager is installed
if ! command -v home-manager > /dev/null; then
    echo ">> home-manager not found. Attempting to install..."
    # Naive attempt to install home-manager
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
    nix-shell '<home-manager>' -A install
fi

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$HOME/.config/home-manager"

mkdir -p "$CONFIG_DIR"

mv "$CONFIG_DIR/home.nix" "$CONFIG_DIR/home.nix.bak" 2>/dev/null || true
ln -sf "$REPO_ROOT/home.nix" "$CONFIG_DIR/home.nix"

# Manual backup of .zshrc to avoid Home Manager clobber error
if [ -e "$HOME/.zshrc" ]; then
    echo ">> Backing up existing .zshrc..."
    mv "$HOME/.zshrc" "$HOME/.zshrc.before-nix"
fi

echo ">> Applying Home Manager configuration..."
home-manager switch

# Set as default (Home Manager manages config, but we need to ensure we are in Zsh)
CURRENT_SHELL=$(getent passwd "$USER" | cut -d: -f7)
if [ "$(basename "$CURRENT_SHELL")" != "zsh" ]; then
    echo ">> Changing default shell to zsh..."
    if command -v sudo > /dev/null; then
        sudo chsh -s "$(which zsh)" "$USER"
    else
        chsh -s "$(which zsh)"
    fi
fi

echo ">> Setup complete."
