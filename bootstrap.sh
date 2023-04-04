# install homebrew
echo "installing homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(
	echo
	echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'
) >>"$PWD/.zprofile"
eval "$(/opt/homebrew/bin/brew shellenv)"

# installing various software from brew using Brewfile
echo "installing all software"
brew bundle --file $(dirname $0)/_bootstrap/gBrewfile

echo "setting up mac with default configurations"
chmod +x $(dirname $0)/_bootstrap/gmacos.zsh
$(dirname $0)/_bootstrap/gmacos.zsh
python $(dirname $0)/_bootstrap/set-chrome-default-browser.py

# set wallpaper
pget https://www.xtrafondos.com/wallpapers/superman-de-espaldas-7443.jpg -o ~/Pictures/superman-wallpaper.jpg
osascript
tell application "Finder"
set desktop picture to POSIX file "~/Pictures/superman-wallpaper.jpg"
end tell

# setup ssh
echo "setting up ssh"
# TODO: find a way to inject my private key to ssh
chmod 400 ~/.ssh/id_rsa

# chrome-cli login to my default user, and set chrome as default browser
echo "setting up obsidian"
git clone git@github.com:dormunis/obsidian-vault.git ~/Documents/obsidian-vault

# setting up different software that are not bound by dotfiles
defaults import com.googlecode.iterm2 $(dirname $0)/_bootstrap/giterm2.plist

echo "setting up dotfiles symlinks"
# TODO: copy dotfiles to this directory and symlink them
mkdir -p ~/.config
ln -s "$PWD/.gitconfig" ~/.config/.gitconfig
ln -s "$PWD/zsh" ~/.config/zsh
ln -s "$PWD/zsh/.zshrc" ~/.zshrc
ln -s "$PWD/tmux" ~/.config/tmux
ln -s "$PWD/nvim" ~/.config/nvim
ln -s "$PWD/yabai" ~/.config/yabai
ln -s "$PWD/skhd" ~/.config/skhd

# setup python
echo "installing python 3.11"
pyenv install 3.11
pyenv global 3.11

# install rust
echo "installing rust latest version"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# initializing addons
# fzf setup
$(brew --prefix)/opt/fzf/install
# setting up yabai and skhd
brew services start yabai skhd
