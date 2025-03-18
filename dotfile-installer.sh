echo '***************************************************'
echo 'INSTALL ~> nvim'
echo '***************************************************'
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz
tar xzf nvim-macos-arm64.tar.gz
rm nvim-macos-arm64.tar.gz

DOTPATH=~/workspace/sivchari/dotfiles

ln -snfv "$DOTPATH/.zshrc" "$HOME/.zshrc"
mkdir -p $HOME/.config/sheldon
ln -snfv "$DOTPATH/plugins.toml" "$HOME/.config/sheldon/plugins.toml"
ln -snfv "$DOTPATH/.gitconfig" "$HOME/.gitconfig"
mkdir -p ~/Library/Application\ Support/lazygit
ln -snfv "$DOTPATH/config.yml" ~/Library/Application\ Support/lazygit/config.yml
mkdir -p ~/.config/mise
ln -snfv "$DOTPATH/config.toml" "$HOME/.config/mise/config.toml"
mkdir -p $HOME/.config/nvim
ln -snfv "$DOTPATH/init.lua" "$HOME/.config/nvim/init.lua"
ln -sv "$DOTPATH/lua" "$HOME/.config/nvim/"

echo '***************************************************'    
echo 'aqua'    
echo '***************************************************'    
curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v3.1.1/aqua-installer | bash
AQUA_GLOBAL_CONFIG=$HOME/workspace/sivchari/dotfiles/aqua.yaml aqua i -a

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

