# Config file for Powerlevel10k with the style 'lean'.
# Modified for valid m8a example.

# Temporarily disabled full config for brevity, but this file 
# forces p10k to load without asking the user to run the wizard immediately
# if they don't want to.

(( ! $+functions[p10k] )) || p10k display '1/1'

typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  # =========================[ Line #1 ]=========================
  os_icon                 # os identifier
  dir                     # current directory
  vcs                     # git status
  # =========================[ Line #2 ]=========================
  newline                 # \n
  prompt_char             # prompt symbol
)

typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  status                  # exit code of the last command
  command_execution_time  # duration of the last command
  background_jobs         # presence of background jobs
  # context                 # user@hostname
  time                    # current time
)

typeset -g POWERLEVEL9K_MODE=nerdfont-complete
