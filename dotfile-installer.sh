print_header() {
  printf "\e[34m"
  echo '--------------------------------------------------------------------------------'
  echo '                                                                                '
  echo '                 888          888     .d888 d8b 888                             '
  echo '                 888          888    d88P"  Y8P 888                             '
  echo '                 888          888    888        888                             '
  echo '             .d88888  .d88b.  888888 888888 888 888  .d88b.  .d8888b            '
  echo '            d88" 888 d88""88b 888    888    888 888 d8P  Y8b 88K                '
  echo '            888  888 888  888 888    888    888 888 88888888 "Y8888b.           '
  echo '            Y88b 888 Y88..88P Y88b.  888    888 888 Y8b.          X88           '
  echo '             "Y88888  "Y88P"   "Y888 888    888 888  "Y8888   88888P"           '
  echo '                                                                                '
  echo '                       thanks for installing my dotfiles                        '
  echo '                                                                                '
  echo '                         github.com/sivchari/dotfiles                           '
  echo '                                                                                '
  echo '--------------------------------------------------------------------------------'
  printf "\e[0m\n"
}

print_header

DOTPATH=~/workspace/dotfiles


ln -snfv "$DOTPATH/.gitconfig" "$HOME/.gitconfig"
ln -snfv "$DOTPATH/.zshrc" "$HOME/.zshrc"
ln -snfv "$DOTPATH/.tmux.conf" "$HOME/.tmux.conf"
ln -snfv "$DOTPATH/config.yml" "~/Library/Application Support/lazygit/config.yml"

echo '***************************************************'
echo 'install homebrew'
echo '***************************************************'
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/s15301/.profile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew -v

echo '***************************************************'
echo 'install zsh'
echo '***************************************************'
brew install zsh

echo '***************************************************'
echo 'INSTALL ~> zsh-completions'
echo '***************************************************'
brew install zsh-completions

# echo '***************************************************'
# echo 'INSTALL ~> zsh-autosuggestions'
# echo '***************************************************'
# brew install zsh-autosuggestions

echo '***************************************************'
echo 'INSTALL ~> finch'
echo '***************************************************'
brew install finch

echo '***************************************************'
echo 'INSTALL ~> rustup'
echo '***************************************************'
brew install rustup-init

echo '***************************************************'
echo 'INSTALL ~> go'
echo '***************************************************'
brew install go

echo '***************************************************'
echo 'INSTALL ~> nvim'
echo '***************************************************'
brew install neovim
mkdir -p $HOME/.config/nvim
ln -snfv "$DOTPATH/init.lua" "$HOME/.config/nvim/init.lua"
ln -snfv "$DOTPATH/coc-settings.json" "$HOME/.config/nvim/coc-settings.json"
ln -sv "$DOTPATH/lua/" "$HOME/.config/nvim/lua"

echo '***************************************************'    
echo 'INSTALL tmux'    
echo '***************************************************'    
brew install tmux    

echo '***************************************************'    
echo 'INSTALL terraform-ls'    
echo '***************************************************'    
brew install terraform-ls

echo '***************************************************'    
echo 'INSTALL git-delta'    
echo '***************************************************'    
brew install git-delta    

echo '***************************************************'    
echo 'INSTALL jq'    
echo '***************************************************'    
brew install jq    

echo '***************************************************'    
echo 'INSTALL llvm'    
echo '***************************************************'    
brew install llvm    

echo '***************************************************'    
echo 'INSTALL ripgrep'    
echo '***************************************************'    
brew install ripgrep    

echo '***************************************************'    
echo 'INSTALL htop'    
echo '***************************************************'    
brew install htop

echo '***************************************************'    
echo 'INSTALL jo'    
echo '***************************************************'    
brew install jo   

echo '***************************************************'    
echo 'INSTALL ghq'
echo '***************************************************'    
brew install ghq
git config --global ghq.root '~/workspace'

echo '***************************************************'    
echo 'INSTALL bat'
echo '***************************************************'    
brew install bat

echo '**************************************************'
echo 'DOTFILES SETUP FINISHED! bye.'
echo 'PLEASE CHANGE TO YOUR FONT OF POWERLINE YOU WANNA :)'
echo '**************************************************'
