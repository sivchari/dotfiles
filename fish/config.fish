alias w='cd ~/workspace'


alias dcd='docker-compose down'
alias dce='docker-compose exec'
alias dcp='docker-compose ps'
alias dcud='docker-compose up -d'
alias dcubd='docker-compose up --build -d'
alias di='docker images'
alias dp='docker ps'
alias dr='docker rm'
alias drmi='docker rmi'
alias dv='docker volume ls'
alias dvr='docker volume rm'

alias g='git'
alias vi='nvim'
alias c=clear

eval (/opt/homebrew/bin/brew shellenv | source)
set -x PATH $HOME/.cargo/bin $PATH

set -x PATH $HOME/workspace/Nim/bin $PATH
set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin
set -x PATH $PLAN9 /usr/local/plan9

alias bash=/opt/homebrew/bin/bash
set -x DOCKER_HOST 'tcp://127.0.0.1:2375'

