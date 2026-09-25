# Dotfiles

This repository contains my personal dotfiles for configuring various tools and applications.

## Setup

The home-directory files are symlinks into this repo:

```sh
for f in .zshrc .zshenv .zprofile; do ln -sf ~/dotfiles/zsh/$f ~/$f; done
```

CLI tools come from Homebrew; zinit (bootstrapped by `.zshrc`) only manages zsh plugins and the Pure prompt.

```sh
brew install bat fd ripgrep git-delta dust uv fzf zoxide difftastic eza
```
