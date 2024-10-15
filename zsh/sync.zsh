export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/workspace/go/go/bin:$PATH
export PATH=$HOME/workspace/sivchari/dotfiles/nvim-macos-arm64/bin:$PATH
export GOBIN=$HOME/workspace/go/go/bin

eval "$(direnv hook zsh)"
eval "$(~/.local/share/aquaproj-aqua/bin/mise activate zsh)"
alias k='kubectl'

function git_branch() {
  git rev-parse --abbrev-ref HEAD 2> /dev/null
}

function kube_context() {
  kubectl config current-context 2> /dev/null
}

function set_prompt() {
  local git_branch_info=$(git_branch)
  local kube_context_info=$(kube_context)

  PROMPT=""

  if [ -n "$git_branch_info" ]; then
    PROMPT+=" %F{green}($git_branch_info)%f"
  fi

  if [ -n "$kube_context_info" ]; then
    PROMPT+=" %F{blue}($kube_context_info)%f"
  fi

  PROMPT+=" %# "
}

function plan9port() {
  export PATH=$HOME/workspace/plan9/bin:$PATH
  export PATH=$HOME/plan9port/bin:$PATH
}

setopt PROMPT_SUBST
precmd_functions+=(set_prompt)
