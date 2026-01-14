export PATH=$HOME/workspace/go/go/bin:$PATH
export PATH=$HOME/workspace/go/tinygo/build:$PATH
export PATH=$HOME/.cargo/bin:$PATH

# Go/TinyGo source builds (OSS development)
export GOBIN=$HOME/workspace/go/go/bin
export GOROOT_BOOTSTRAP=$HOME/workspace/go/go-darwin-arm64-bootstrap
export TINYGO_GOCOMPATIBILITY=0

export GPG_TTY=$(tty)
export EDITOR="vim"

alias k='kubectl'
alias g='git'
alias w='cd ~/workspace'
alias vi='nvim'
alias c='clear'
alias acme='9 acme -f /mnt/font/"GoMono-Bold"/15a/font'
alias claude-personal='CLAUDE_CONFIG_DIR=~/.claude-personal claude'

function git_branch() {
  git rev-parse --abbrev-ref HEAD 2> /dev/null
}

function kube_context() {
  kubectl config current-context 2> /dev/null
}

function set_prompt() {
  local git_branch_info=$(git_branch)
  local kube_context_info=$(kube_context)

  PROMPT="%~ "

  if [ -n "$git_branch_info" ]; then
    PROMPT+=" %F{green}($git_branch_info)%f"
  fi

  if [ -n "$kube_context_info" ]; then
    PROMPT+=" %F{blue}($kube_context_info)%f"
  fi

  PROMPT+=" %# "
}

function plan9port() {
  export PLAN9=${$(command -v 9):A:h:h}
  export PATH=$PLAN9/bin:$PATH
}

function gr() {
  FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --reverse --height=50%"
  local root="$HOME/workspace"
  local repo="$(ghq list | fzf --preview="ls -AF --color=always ${root}/{1}")"
  local dir="${root}/${repo}"
  [ -n "${dir}" ] && cd "${dir}"
}

setopt PROMPT_SUBST
precmd_functions+=(set_prompt)
