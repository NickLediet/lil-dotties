# root config alias frorm globally using repository
alias config='/usr/bin/git --git-dir=$HOME/.lil-dotties/ --work-tree=$HOME'

# lil-dotties aliases
function lil {
	$(cd ~/.lil-src && make $1)
}


# Docker aliases
function dnuke {
	docker rm $(docker ps -aq)
}

# git aliases
alias gst="git status"
alias gadd="git add"
alias gcm="git commit -m"
alias gp="git push"

# config git alias ports
alias cst="config status"
alias cadd="config add"
alias ccm="config commit -m"
# don't use unless you really want to
# just use `config push`
# alias cpush="config push"

# general utils
alias reload="source ~/.bashrc"
