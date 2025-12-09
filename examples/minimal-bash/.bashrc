# Minimal Bash RC

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# History
HISTSIZE=1000
HISTFILESIZE=2000

# Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias gs='git status'
alias gp='git pull'

# Prompt
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

echo "Loaded Minimal Bash Configuration"
