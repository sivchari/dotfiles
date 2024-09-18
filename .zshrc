alias w='cd ~/workspace'
alias g='git'
alias k='kubectl'
alias vi='$HOME/workspace/sivchari/dotfiles/nvim-macos-arm64/bin/nvim'
alias c='clear'
alias acme='acme -f /mnt/font/'GoMono-Bold'/15a/font'

function gr() {
    FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --reverse --height=50%"
    local root="$(ghq root)"
    local repo="$(ghq list | fzf --preview="ls -AF --color=always ${root}/{1}")"
    local dir="${root}/${repo}"
    [ -n "${dir}" ] && cd "${dir}"
}

typeset -U path PATH
path=(
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
  $HOME/plan9port/bin
  $HOME/workspace/go/go/bin
)

# Zig
export PATH=$HOME/workspace/zig/zig/build/stage3/bin:$PATH

# Go
export GOROOT_BOOTSTRAP=$HOME/workspace/go/go-darwin-arm64-bootstrap
export GOBIN=$HOME/workspace/go/go/bin
export GOPATH=$HOME/workspace/go

# zsh
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

# kube-ps1
setopt PROMPT_SUBST ; PS1='$(kube_ps1) %F{cyan}%~%f%F{red}$(__git_ps1) '
source ~/workspace/sivchari/dotfiles/kube-ps1.sh
KUBE_PS1_SYMBOL_ENABLE=false
KUBE_PS1_NS_ENABLE=false
source <(kubectl completion zsh)

# Aqua
export PATH=${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH
export AQUA_GLOBAL_CONFIG=$HOME/workspace/sivchari/dotfiles/aqua.yaml

# mise
eval "$(~/.local/share/aquaproj-aqua/bin/mise activate zsh)"

# direnv
eval "$(direnv hook zsh)"
