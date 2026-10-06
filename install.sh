#!/bin/sh
# Symlink dotfiles into $HOME. A real file already in the way is moved to
# <name>.bak.<timestamp> first, so nothing is overwritten.
set -e
cd "$(dirname "$0")"

# link <repo path> <destination>
link() {
    mkdir -p "$(dirname "$2")"
    if [ -e "$2" ] && [ ! -L "$2" ]; then
        mv "$2" "$2.bak.$(date +%Y%m%d%H%M%S)"
        echo "backed up $2"
    fi
    ln -sfn "$PWD/$1" "$2"
    echo "linked $2 -> $PWD/$1"
}

for f in zsh/.zshenv zsh/.zprofile zsh/.zshrc vim/.vimrc git/.gitconfig; do
    link "$f" "$HOME/$(basename "$f")"
done
link git/ignore "$HOME/.config/git/ignore"
link nvim "$HOME/.config/nvim"
