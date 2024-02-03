#!/bin/zsh
# setup ssh
echo "setting up ssh"
# TODO: find a way to inject my private key to ssh
chmod 400 ~/.ssh/id_rsa

echo "setting up dev directroy in ~/dev and cloning dotfiles"
mkdir -r ~/dev
dotfilesdir=~/dev/private/dotfiles
git clone git@github.com:dormunis/dotfiles.git $dotfilesdir

# install homebrew
# TODO: put .zprofile in dotfiles as well
echo "installing homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(
	echo
	echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'
) >>"$PWD/.zprofile"
eval "$(/opt/homebrew/bin/brew shellenv)"

# installing various software from brew using Brewfile
echo "installing all software"
brew bundle --file $dotfilesdir/_bootstrap/Brewfile

echo "setting up mac with default configurations"
chmod +x $dotfilesdir/_bootstrap/macos.zsh
$dotfilesdir/_bootstrap/macos.zsh
python $dotfilesdir/_bootstrap/set-default-browser.py

# set wallpaper
mv $dotfilesdir/_bootstrap/superman-wallpaper.jpg ~/Pictures/superman-wallpaper.jpg
osascript
tell application "Finder"
set desktop picture to POSIX file "$HOME/Pictures/superman-wallpaper.jpg"
end tell

# chrome-cli login to my default user, and set chrome as default browser
echo "setting up obsidian"
git clone git@github.com:dormunis/obsidian-vault.git ~/Documents/obsidian-vault

echo "setting up dotfiles symlinks"
# TODO: copy dotfiles to this directory and symlink them
mkdir -p ~/.config
mkdir -p ~/.local/bin
for file in $dotfilesdir/bin/*; do ln -s "$file" ~/.local/bin/"$(basename "$file" | sed 's/\..*//')"; done
ln -s "$dotfilesdir/.gitconfig" ~/.config/.gitconfig
ln -s "$dotfilesdir/zsh" ~/.config/zsh
ln -s "$dotfilesdir/zsh/.zshrc" ~/.zshrc
ln -s "$dotfilesdir/tmux" ~/.config/tmux
ln -s "$dotfilesdir/tmux/.tmux.conf" ~/.tmux.conf
ln -s "$dotfilesdir/nvim" ~/.config/nvim
ln -s "$dotfilesdir/alacritty" ~/.config/alacritty
ln -s "$dotfilesdir/yabai" ~/.config/yabai
ln -s "$dotfilesdir/skhd" ~/.config/skhd

# setup python
echo "installing python 3.11"
pyenv install 3.11
pyenv global 3.11
mkdir "$dotfilesdir/dap-virtualenvs"
cd python -m venv debugpy "$dotfilesdir/dap-virtualenvs"
$dotfilesdir/debugpy/bin/pip install debugpy
ln -s "$dotfilesdir/dap-virtualenvs" ~/.config/dap-virtualenvs

# install bun
echo "installing bun"
curl -fsSL https://bun.sh/install | sh

# install rust
echo "installing rust latest version"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

echo "initializing addons"
# fzf setup
$(brew --prefix)/opt/fzf/install
# setting up yabai and skhd
brew services start yabai skhd
