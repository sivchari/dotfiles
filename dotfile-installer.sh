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

DOTPATH=~/workspace/sivchari/dotfiles

ln -snfv "$DOTPATH/.gitconfig" "$HOME/.gitconfig"
ln -snfv "$DOTPATH/.zshrc" "$HOME/.zshrc"
ln -snfv "$DOTPATH/config.yml" "~/Library/Application Support/lazygit/config.yml"
echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc

echo '***************************************************'
echo 'install shell plugins'
echo '***************************************************'
bash zsh_plugins.sh

echo '***************************************************'
echo 'install zsh-syntax-highlighting'
echo '***************************************************'
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

echo '***************************************************'
echo 'INSTALL ~> nvim'
echo '***************************************************'
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz
tar xzf nvim-macos-arm64.tar.gz
./nvim-macos-arm64/bin/nvim
mkdir -p $HOME/.config/nvim
ln -snfv "$DOTPATH/init.lua" "$HOME/.config/nvim/init.lua"
ln -sv "$DOTPATH/lua" "$HOME/.config/nvim/"

echo '***************************************************'    
echo 'aqua'    
echo '***************************************************'    
curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v3.0.1/aqua-installer | bash
aqua i -a

echo '***************************************************'    
echo 'Setting ghq'    
echo '***************************************************'    
git config --global ghq.root '~/workspace'

echo '***************************************************'    
echo 'INSTALL plan9port'
echo '***************************************************'    
cd $HOME && \
git clone https://github.com/9fans/plan9port plan9port && \
cd plan9port && \
./INSTALL && \
cd $HOME/workspace/dotfiles && \
cp Slide ~/plan9port/bin && \
cp Slide+ ~/plan9port/bin && \
cp Slide- ~/plan9port/bin && \
cp sn ~/plan9port/bin && \
cp sts ~/plan9port/bin

