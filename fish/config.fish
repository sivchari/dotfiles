alias w='cd ~/workspace'

alias fcd='finch compose down'
alias fce='finch compose exec'
alias fcp='finch compose ps'
alias fcud='finch compose up -d'
alias fi='finch images'
alias fp='finch ps'
alias fr='finch rm'
alias frmi='finch rmi'
alias fv='finch volume ls'
alias fvr='finch volume rm'

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
