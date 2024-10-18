# Define color variables for zsh using ANSI escape sequences
GREEN='%F{green}'
BLUE='%F{blue}'
GREY='%F{grey}'
DIM='%F{#675d57}'
RED='%F{#d15654}'
RESET='%f'

# Set colorful terminal prompt with a dim grey @ symbol
PS1="[${GREEN}%n${DIM}@${RED}%m ${BLUE}%~${RESET}] "


autoload -Uz +X compinit && compinit

## case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select


# Function for adding to the PATH
path_append() {
	if [[ ":$PATH:" != *":$1:"* ]]; then
		export PATH="$1:$PATH"
	fi
}

path_append "$HOME/dev/scripts"


# Aliases
alias so="source"
alias soz="exec zsh -l"
alias ls='ls -1a --color=auto'
alias ebr='nvim $HOME/.zshrc'

alias cmx="chmod +x"
alias ls="ls -1AF --color=auto"
alias grep='grep --color=auto'
alias vim="NO_TRACK_SESSION=1 nvim"
alias ebr="vim $HOME/.zshrc"
alias ebp="vim $HOME/.zprofile"
alias egc="vim $HOME/.gitconfig"
alias tmux="tmux -u"
alias tmk="tmux kill-server"
alias tmc="vim $HOME/dotfiles/.tmux.conf"
alias tmso="tmux source-file $HOME/.tmux.conf"
alias lg="lazygit"
alias pea="so $HOME/dev/pyenvs/pyenv_backend/bin/activate"
alias ped="deactivate"
