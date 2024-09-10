# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"


# Fixes color and theme issues in tmux
export TERM=screen-256color-bce


export PATH="/opt/homebrew/bin:$PATH"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
autoload -Uz compinit && compinit


# Bring in bash aliases
source ~/.bash_aliases

# Lando
export PATH="/Users/nle/.lando/bin${PATH+:$PATH}"; #landopath
