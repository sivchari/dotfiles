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

echo '***************************************************'
echo '*COMPLETED LINKS ~> dotfiles'
echo '****************************************************'

echo '***************************************************'
echo 'install homebrew'
echo '***************************************************'
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/s15301/.profile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew -v
echo '***************************************************'
echo 'COMPLETED INSTALL ~> HOMEBREW'
echo '***************************************************'

echo '***************************************************'
echo 'INSTALL ~> bash'
echo '***************************************************'
brew install bash
echo '***************************************************'
echo 'COMPLETED INSTALL ~> bash'
echo '***************************************************'

echo '***************************************************'
echo 'INSTALL ~> nvim'
echo '***************************************************'
brew install neovim
mkdir -p $HOME/.config/nvim
ln -snfv "$DOTPATH/init.lua" "$HOME/.config/nvim/init.lua"
ln -snfv "$DOTPATH/coc-settings.json" "$HOME/.config/nvim/coc-settings.json"
ln -sv "$DOTPATH/lua/" "$HOME/.config/nvim/lua"
echo '***************************************************'
echo 'COMPLETED INSTALL ~> nvim'
echo '***************************************************'

echo '***************************************************'
echo 'INSTALL fish'
echo '***************************************************'
brew install fish
fish -v
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish
echo '***************************************************'
echo 'COMPLETED INSTALL ~> FISH'
echo '***************************************************'

echo '***************************************************'    
echo 'INSTALL tmux'    
echo '***************************************************'    
brew install tmux    
echo '***************************************************'    
echo 'COMPLETED INSTALL ~> tmux'    
echo '***************************************************'

echo '***************************************************'    
echo 'INSTALL git-delta'    
echo '***************************************************'    
brew install git-delta    
echo '***************************************************'    
echo 'COMPLETED INSTALL ~> git-delta'    
echo '***************************************************'

echo '***************************************************'    
echo 'INSTALL jq'    
echo '***************************************************'    
brew install jq    
echo '***************************************************'    
echo 'COMPLETED INSTALL ~> jq'    
echo '***************************************************'

echo '***************************************************'    
echo 'INSTALL llvm'    
echo '***************************************************'    
brew install llvm    
echo '***************************************************'    
echo 'COMPLETED INSTALL ~> llvm'    
echo '***************************************************'

echo '***************************************************'    
echo 'INSTALL ripgrep'    
echo '***************************************************'    
brew install ripgrep    
echo '***************************************************'    
echo 'COMPLETED INSTALL ~> ripgrep'    
echo '***************************************************'

echo '***************************************************'    
echo 'INSTALL htop'    
echo '***************************************************'    
brew install htop
echo '***************************************************'    
echo 'COMPLETED INSTALL ~> jq'    
echo '***************************************************'

echo '***************************************************'    
echo 'INSTALL jo'    
echo '***************************************************'    
brew install jo   
echo '***************************************************'    
echo 'COMPLETED INSTALL ~> jo'    
echo '***************************************************'

echo '***************************************************'
echo 'install fisherman'
echo '***************************************************'
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
echo '***************************************************'
echo 'COMPLETED INSTALL ~> FISHERMAN'
echo '***************************************************'

echo '***************************************************'    
echo 'INSTALL ghq'
echo '***************************************************'    
brew install ghq
git config --global ghq.root '~/workspace'
echo '***************************************************'
echo 'COMPLETED INSTALL ~> ghq'
echo '***************************************************'

echo '***************************************************'    
echo 'INSTALL fzf'
echo '***************************************************'    
brew install fzf
fisher install jethrokuan/fzf
echo '***************************************************'
echo 'COMPLETED INSTALL ~> fzf'
echo '***************************************************'

echo '***************************************************'    
echo 'INSTALL bat'
echo '***************************************************'    
brew install bat
echo '***************************************************'
echo 'COMPLETED INSTALL ~> bat'
echo '***************************************************'

echo '***************************************************'
echo "fisher set up"
echo '***************************************************'
cp -r "$DOTPATH/fish" "$HOME/.config"
echo '***************************************************'
echo 'COMPLETED SETUP ~> FISHER'
echo '***************************************************'

echo '***************************************************'
echo "plan9port set up"
echo '***************************************************'
cd ~/workspace
git clone https://github.com/9fans/plan9port plan9
cd plan9
./INSTALL
echo '***************************************************'
echo 'COMPLETED SETUP ~> plan9port'
echo '***************************************************'

echo '**************************************************'
echo 'DOTFILES SETUP FINISHED! bye.'
echo 'PLEASE CHANGE TO YOUR FONT OF POWERLINE YOU WANNA :)'
echo '**************************************************'
fish
