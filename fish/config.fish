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
alias a='acme -a -f /mnt/font/GoMono/14a/font'
alias f='fontsrv'

eval (/opt/homebrew/bin/brew shellenv | source)
set -x PATH $HOME/.cargo/bin $PATH

set -x PATH $HOME/workspace/Nim/bin $PATH
set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin
set -x PLAN9 /Users/(whoami)/workspace/plan9
set -x PATH $PATH $PLAN9/bin

alias bash=/opt/homebrew/bin/bash

function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
  bind \cg 'peco_ghq'
end

function peco_ghq
  set selected_repository (ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_repository" ]
    cd $selected_repository
    commandline -f repaint
  end
end

