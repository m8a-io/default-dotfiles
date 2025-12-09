export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell" # Simple theme, focus is on aliases

plugins=(git kubectl docker helm terraform aws)

source $ZSH/oh-my-zsh.sh

# --- DevOps Aliases ---
alias k="kubectl"
alias kg="kubectl get"
alias kga="kubectl get all"
alias kd="kubectl describe"
alias kdel="kubectl delete"

alias d="docker"
alias dc="docker-compose"

alias tf="terraform"

alias gcloud-login="gcloud auth login"
alias aws-login="aws sso login"

echo ">> DevOps Toolbox Loaded"
echo ">>   k  -> kubectl"
echo ">>   d  -> docker"
echo ">>   tf -> terraform"
