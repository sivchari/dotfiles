export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/workspace/plan9/bin:$PATH
export PATH=$HOME/plan9port/bin:$PATH
export PATH=$HOME/workspace/go/go/bin:$PATH

# this alias must be loaded synchronously for sheldon.
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

  if [ -n "$git_branch_info" ]; then
    PROMPT=" %F{green}($git_branch_info)%f"
  fi

  if [ -n "$kube_context_info" ]; then
    PROMPT+=" %F{blue}($kube_context_info)%f"
  fi

  PROMPT+=" %# "
}

setopt PROMPT_SUBST
precmd_functions+=(set_prompt)
