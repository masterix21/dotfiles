#!/bin/bash

set -e  # Exit on error (but we use || true for optional steps)

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

step() { echo ""; echo -e "${BLUE}➜${NC} $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warn() { echo -e "${YELLOW}⚠${NC} $1"; }
error() { echo -e "${RED}✗${NC} $1"; exit 1; }

echo ""
step "Setting up your Mac ❤️..."
echo ""
warn "This will install/update your terminal setup"
echo ""
read -p "Continue? (y/n) " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    step "Cancelled"
    echo ""
    exit 0
fi

echo ""
sudo -v

step "Installing Oh My Zsh"
if [ ! -d ~/.oh-my-zsh ]; then
    rm -rf ~/.oh-my-zsh
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh -s -- --unattended || warn "Oh My Zsh installation failed"
fi
success "Oh My Zsh installed"
echo ""

if [[ "$(/usr/bin/uname -m)" == "arm64" ]]
then
  HOMEBREW_PATH="/opt/homebrew"
else
  HOMEBREW_PATH="/usr/local"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  echo 'eval "$('$HOMEBREW_PATH'/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$($HOMEBREW_PATH/bin/brew shellenv)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc


# Update Homebrew recipes
$HOMEBREW_PATH/bin/brew update

if [[ "$(/usr/bin/uname -m)" == "arm64" ]]
then
  # Install Rosetta
  sudo softwareupdate --install-rosetta
fi

# Install all the dependencies with bundle (See Brewfile)
$HOMEBREW_PATH/bin/brew bundle --file $HOME/.dotfiles/Brewfile

# Install global Composer packages
composer global require laravel/installer laravel/valet laravel/pint laravel/envoy spatie/phpunit-watcher beyondcode/expose

# Install Laravel Valet
if ! $HOME/.composer/vendor/bin/valet --version &> /dev/null; then
    $HOME/.composer/vendor/bin/valet install
fi

# Create a Sites directories
mkdir -p $HOME/Dev/Sites $HOME/Dev/Packages $HOME/Dev/Forks $HOME/Dev/Mobile

# Install ZSH autosuggestion plugin
if [ ! -d "$HOME/.dotfiles/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.dotfiles/plugins/zsh-autosuggestions
fi

# Symlink the Mackup config file to the home directory
ln -sf $HOME/.dotfiles/.mackup.cfg $HOME/.mackup.cfg

# Symlink bin scripts
mkdir -p $HOME/bin
ln -sf $HOME/.dotfiles/bin/setup-php $HOME/bin/setup-php
success "bin scripts symlinked"

# Install PECL extensions and configure xdebug for all PHP versions
$HOME/bin/setup-php || warn "PHP setup failed"

# Symlink gitconfig and global gitignore
ln -sf $HOME/.dotfiles/home/.gitconfig $HOME/.gitconfig
ln -sf $HOME/.dotfiles/home/.global-gitignore $HOME/.global-gitignore
success "Gitconfig and global gitignore symlinked"

# Symlink Starship config
mkdir -p $HOME/.config
ln -sf $HOME/.dotfiles/config/starship.toml $HOME/.config/starship.toml
success "Starship config symlinked"

# Setup fnm (Node version manager)
if command -v fnm &> /dev/null; then
    eval "$(fnm env --shell bash)"
    fnm install --lts || warn "fnm LTS install failed"
    fnm use lts-latest || warn "fnm use lts-latest failed"
    success "fnm configured"
fi

# Setup fzf keybindings
if command -v fzf &> /dev/null; then
    $(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc || warn "fzf install failed"
    success "fzf keybindings installed"
fi

# Set macOS preferences
# We will run this last because this will reload the shell
source .macos
