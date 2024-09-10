
export PATH="/opt/homebrew/bin:$PATH"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
autoload -Uz compinit && compinit


# Bring in bash aliases
source ~/.bash_aliases

# Lando
export PATH="/Users/nle/.lando/bin${PATH+:$PATH}"; #landopath