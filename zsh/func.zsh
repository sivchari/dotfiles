function gr() {
    FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --reverse --height=50%"
    local root="$HOME/workspace"
    local repo="$(cat ~/workspace/sivchari/dotfiles/ghq_list.txt | fzf --preview="ls -AF --color=always ${root}/{1}")"
    local dir="${root}/${repo}"
    [ -n "${dir}" ] && cd "${dir}"
}
