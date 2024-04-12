# Path to your dotfiles installation.
export DOTFILES=$HOME/.dotfiles

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$DOTFILES

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git laravel composer macos zsh-autosuggestions)

# Set zsh-autosuggestions color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

# Activate Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LC_ALL=it_IT.UTF-8
export LANG=it_IT.UTF-8

# Editors
export EDITOR='nano'
export OPEN_ON_MAKE_EDITOR="pstorm"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

if [[ "$(/usr/bin/uname -m)" == "arm64" ]]
then
  HOMEBREW_PATH="/opt/homebrew"
else
  HOMEBREW_PATH="/usr/local"
fi

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOMEBREW_PATH/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$HOME/.pub-cache/bin:$PATH"

source "$DOTFILES/.aliases"
source "$DOTFILES/.functions"

# bun completions
[ -s "/Users/luca/.bun/_bun" ] && source "/Users/luca/.bun/_bun"


# Herd injected NVM configuration
export NVM_DIR="/Users/luca/Library/Application Support/Herd/config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

[[ -f "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh" ]] && builtin source "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh"

# Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="/Users/luca/Library/Application Support/Herd/config/php/83/"


# Herd injected PHP binary.
export PATH="/Users/luca/Library/Application Support/Herd/bin/":$PATH
