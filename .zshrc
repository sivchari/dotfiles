alias w='cd ~/workspace'
alias dcd='docker compose down'
alias dce='docker compose exec'
alias dcp='docker compose ps'
alias dcubd='docker compose up --build -d'
alias dimages='docker images'
alias dp='docker ps'
alias dr='docker rm'
alias drmi='docker rmi'
alias dv='docker volume ls'
alias dvr='docker volume rm'
alias g='git'
alias k='kubectl'
alias vi='nvim'
alias c='clear'
alias acme='acme -f /mnt/font/'GoMono-Bold'/15a/font'

function gr() {
    FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --reverse --height=50%"
    local root="$(ghq root)"
    local repo="$(ghq list | fzf --preview="ls -AF --color=always ${root}/{1}")"
    local dir="${root}/${repo}"
    [ -n "${dir}" ] && cd "${dir}"
}

export GOROOT_BOOTSTRAP=$HOME/workspace/go/go/go-darwin-arm64-bootstrap
export GOBIN=$HOME/workspace/go/go/bin

export PATH="$PATH:$HOME/workspace/zig/zig/build/stage3/bin"
export PATH="$PATH:$HOME/workspace/zig/zls/zig-out/bin"

typeset -U path PATH
path=(
  /opt/homebrew/bin(N-/)
  /opt/homebrew/sbin(N-/)
  $HOME/.cargo/bin
  $GOBIN
  /usr/bin
  /usr/sbin
  /bin
  /sbin
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /Library/Apple/usr/bin
  $HOME/workspace/plan9/bin
)

source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions.zsh
source ~/.zsh/git-prompt.sh

fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.zsh
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto
GIT_PS1_SHOWDIRTYSTATE=true

KUBE_PS1_PREFIX="["
KUBE_PS1_SUFFIX="]"
KUBE_PS1_SYMBOL_ENABLE=true
KUBE_PS1_NS_ENABLE=false
source /opt/homebrew/Cellar/kube-ps1/0.8.0/share/kube-ps1.sh
setopt PROMPT_SUBST ; PS1='$(kube_ps1) %F{cyan}%~%f%F{red}$(__git_ps1) '


export PLAN9="$HOME/plan9port"
export PATH="$PATH:$PLAN9/bin"

source <(kubectl completion zsh)
