#=== Steps
#==============================================================================================
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

echo 'start setup...'
for f in .??*
do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".DS_Store" ] && continue

    ln -snfv "$DOTPATH/$f" "$HOME/$f"
done

echo '***************************************************'
echo '*COMPLETED LINKS ~> dotfiles'
echo '****************************************************'

echo 'install homebrew'
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
brew -v
echo '***************************************************'
echo 'COMPLETED INSTALL ~> HOMEBREW'
echo '***************************************************'

echo 'install fish'
brew install fish
fish -v
echo /usr/local/bin/fish > /etc/shells
chsh -s /usr/local/bin/fish
echo '***************************************************'
echo 'COMPLETED INSTALL ~> FISH'
echo '***************************************************'

echo 'install powerline'
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts
echo '***************************************************'
echo 'COMPLETED INSTALL ~> POWERLINE'
echo '***************************************************'

echo 'install fisherman'
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
echo '***************************************************'
echo 'COMPLETED INSTALL ~> FISHERMAN'
echo '***************************************************'

echo "fisher set up"
cp -r "$DOTPATH/fish" "$HOME/.config"
echo '***************************************************'
echo 'COMPLETED SETUP ~> FISHER'
echo '***************************************************'


echo '**************************************************'
echo 'DOTFILES SETUP FINISHED! bye.'
echo 'PLEASE CHANGE TO YOUR FONT OF POWERLINE YOU WANNA :)'
echo '**************************************************'
fish
