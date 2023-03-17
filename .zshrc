eval "$(direnv hook $SHELL)"

alias w='cd ~/workspace'
alias finch='/Applications/Finch/bin/finch'
alias fstart='finch vm start'
alias fstop='finch vm stop'
alias fcd='finch vm stop'
alias fcd='finch compose down'
alias fce='finch compose exec'
alias fcp='finch compose ps'
alias fcud='finch compose up -d'
alias fimages='finch images'
alias fp='finch ps'
alias fr='finch rm'
alias frmi='finch rmi'
alias fv='finch volume ls'
alias fvr='finch volume rm'
alias g='git'
alias vi='nvim'
alias c=clear

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

function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}

zle -N select-history
bindkey '^r' select-history

export GOPATH=$HOME/go/bin

typeset -U path PATH
path=(
  /opt/homebrew/bin(N-/)
  /opt/homebrew/sbin(N-/)
  $HOME/.cargo/bin
  $GOPATH
  /usr/bin
  /usr/sbin
  /bin
  /sbin
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /Library/Apple/usr/bin
)

FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
autoload -Uz compinit && compinit

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
PROMPT='%c '\$vcs_info_msg_0_' '
precmd(){ vcs_info }
