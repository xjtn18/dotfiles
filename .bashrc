# Define color variables for bash using ANSI escape sequences
GREEN='\e[32m'
BLUE='\e[34m'
GREY='\e[90m'
DIM='\e[38;5;242m'  # Approximation for dim grey
RED='\e[38;5;203m'  # Approximation for the red you specified
RESET='\e[0m'

# Set colorful terminal prompt with a dim grey @ symbol
PS1="[${GREEN}\u${DIM}@${RED}\h ${BLUE}\w${RESET}] "

# Function for adding to the PATH
path_append() {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:$PATH"
    fi
}

path_append "$HOME/dev/scripts"
path_append "$HOME/dev/tools/lazygit"

# Aliases
alias so="source"
alias sob="exec bash -l"
alias ls='ls -1AF --color=auto'
alias ebr='vim $HOME/.bashrc'

alias cmx="chmod +x"
alias grep='grep --color=auto'
alias vim="NO_TRACK_SESSION=1 nvim"
alias ebp="vim $HOME/.bash_profile"
alias egc="vim $HOME/.gitconfig"
alias tmux="tmux -u"
alias tmk="tmux kill-server"
alias tmc="vim $HOME/dotfiles/.tmux.conf"
alias tmso="tmux source-file $HOME/.tmux.conf"
alias lg="lazygit"
alias pea="source $HOME/dev/pyenvs/pyenv_backend/bin/activate"
alias ped="deactivate"
