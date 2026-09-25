#!/bin/sh
# Symlink dotfiles into $HOME. A real file already in the way is moved to
# <name>.bak.<timestamp> first, so nothing is overwritten.
set -e
cd "$(dirname "$0")"

for f in zsh/.zshenv zsh/.zprofile zsh/.zshrc vim/.vimrc; do
    dest="$HOME/$(basename "$f")"
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        mv "$dest" "$dest.bak.$(date +%Y%m%d%H%M%S)"
        echo "backed up $dest"
    fi
    ln -sfn "$PWD/$f" "$dest"
    echo "linked $dest -> $PWD/$f"
done
