#!/bin/bash

# Function to install a zsh plugin from a GitHub repository
install_zsh_plugin() {
    local repo=$1
    local dest_dir=$2
    if [ ! -d "$dest_dir" ]; then
        echo "Installing $repo..."
        git clone --depth=1 https://github.com/$repo $dest_dir
    else
        echo "$repo is already installed"
    fi
}

# Check if zsh is installed
if ! command -v zsh &> /dev/null; then
    echo "zsh not found, installing zsh..."
    sudo apt update
    sudo apt install -y zsh
else
    echo "zsh is already installed"
fi

# Check if Oh My Zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh not found, installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh is already installed"
fi

# Check if Powerlevel10k theme is installed
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    echo "Powerlevel10k not found, installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
    # Set ZSH_THEME="powerlevel10k/powerlevel10k" in ~/.zshrc if not already set
    if ! grep -q "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" $HOME/.zshrc; then
        echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> $HOME/.zshrc
    fi
else
    echo "Powerlevel10k is already installed"
fi

# Check if nvm is installed
if [ ! -d "$HOME/.nvm" ]; then
    echo "nvm not found, installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

    # Source nvm script to use it in this shell session
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    # Add nvm initialization to zshrc if not already present
    if ! grep -q 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"' $HOME/.zshrc; then
        echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"' >> $HOME/.zshrc
        echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> $HOME/.zshrc
    fi

    # Optionally, you can install the latest Node.js version
    nvm install node
else
    echo "nvm is already installed"
fi

# Install zsh plugins
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

install_zsh_plugin "lukechilds/zsh-nvm" "$ZSH_CUSTOM/plugins/zsh-nvm"
install_zsh_plugin "zsh-users/zsh-syntax-highlighting" "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
install_zsh_plugin "zsh-users/zsh-autosuggestions" "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
install_zsh_plugin "unixorn/fzf-zsh-plugin" "$ZSH_CUSTOM/plugins/fzf-zsh-plugin"
# install_zsh_plugin "nousr/git-auto-fetch" "$ZSH_CUSTOM/plugins/git-auto-fetch"

# Add plugins to ~/.zshrc if not already present
if ! grep -q "plugins=(git zsh-nvm zsh-syntax-highlighting zsh-autosuggestions fzf-zsh-plugin git-auto-fetch)" $HOME/.zshrc; then
    sed -i 's/plugins=(git)/plugins=(git zsh-nvm zsh-syntax-highlighting zsh-autosuggestions fzf-zsh-plugin git-auto-fetch)/' $HOME/.zshrc
fi

echo "Script completed!"

