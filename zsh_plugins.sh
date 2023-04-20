#! /bin/bash

mkdir ~/.zsh

curl -o ~/.zsh/git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
curl -o ~/.zsh/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
curl -o ~/.zsh/git-completion.zsh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
curl -o ~/.zsh/zsh-autosuggestions.zsh https://raw.githubusercontent.com/zsh-users/zsh-autosuggestions/master/zsh-autosuggestions.zsh
curl -o ~/.zsh/zsh-syntax-highlighting.zsh https://raw.githubusercontent.com/zsh-users/zsh-syntax-highlighting/master/zsh-syntax-highlighting.zsh
