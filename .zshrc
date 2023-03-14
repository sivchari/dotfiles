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

function _fzf_cd_ghq() {
    FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --reverse --height=50%"
    local root="$(ghq root)"
    local repo="$(ghq list | fzf --preview="ls -AF --color=always ${root}/{1}")"
    local dir="${root}/${repo}"
    [ -n "${dir}" ] && cd "${dir}"
    zle accept-line
    zle reset-prompt
}

zle -N _fzf_cd_ghq
bindkey "^g" _fzf_cd_ghq

typeset -U path PATH
path=(
  /opt/homebrew/bin(N-/)
  /opt/homebrew/sbin(N-/)
  $HOME/.cargo/bin
  $HOME/go/bin
  /usr/bin
  /usr/sbin
  /bin
  /sbin
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /Library/Apple/usr/bin
)
