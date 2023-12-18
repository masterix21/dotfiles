#!/bin/sh

echo "Setting up your Mac ❤️..."

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

source $HOME/.zshrc

# Update Homebrew recipes
brew update

# Install Rosetta
sudo softwareupdate --install-rosetta

# Install all the dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file $HOME/.dotfiles/Brewfile

# Install PHP extensions with PECL
pecl install imagick redis

# Install global Composer packages
composer global require laravel/installer laravel/valet beyondcode/expose

# Install Laravel Valet
$HOME/.composer/vendor/bin/valet install

# Create a Sites directories
mkdir $HOME/Dev
mkdir $HOME/Dev/Sites
mkdir $HOME/Dev/Packages
mkdir $HOME/Dev/Forks
mkdir $HOME/Dev/Mobile

# Install ZSH autosuggestion plugin
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.dotfiles/plugins/zsh-autosuggestions

# Symlink the Mackup config file to the home directory
ln -s $HOME/.dotfiles/.mackup.cfg $HOME/.mackup.cfg

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos
