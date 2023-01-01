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

function ghq_fzf_repo -d 'Repository search'
  ghq list --full-path | fzf --reverse --height=100% | read select
  [ -n "$select" ]; and cd "$select"
  echo " $select "
  commandline -f repaint
end

function fish_user_key_bindings
  bind \cg ghq_fzf_repo
  bind \cr __fzf_reverse_isearch
  bind \cd __fzf_cd
end
