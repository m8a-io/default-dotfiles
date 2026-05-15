# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"

# Spaceship theme (installed by dotfiles install.sh)
ZSH_THEME="spaceship"

# Which plugins would you like to load?
plugins=(git z sudo)

source $ZSH/oh-my-zsh.sh

# Preferred editor
export EDITOR='vim'

# aliases
alias zconfig="vim ~/.zshrc"
