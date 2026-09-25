# Dotfiles

This repository contains my personal dotfiles for configuring various tools and applications.

## Setup

```sh
git clone git@github.com:ruiying-ocean/dotfiles.git ~/dotfiles && ~/dotfiles/install.sh
```

`install.sh` symlinks the files into `$HOME`; any real file already there is backed up to `<name>.bak.<timestamp>`.

CLI tools come from Homebrew; zinit (bootstrapped by `.zshrc`) only manages zsh plugins and the Pure prompt.

```sh
brew install bat fd ripgrep git-delta dust uv fzf zoxide difftastic eza
```

## Machine-specific config

The repo holds only what is shared by every machine. Anything that belongs to one machine, including secrets, goes in untracked files, which the tracked ones source at the end:

| File                | For                                                                    |
| ------------------- | ---------------------------------------------------------------------- |
| `~/.zprofile.local` | PATH entries, env vars, API keys, overrides (`MAMBA_ROOT_PREFIX`, `ZSH_COMPINIT_FLAGS=-u` when Homebrew is owned by another account) |
| `~/.zshrc.local`    | interactive hooks (nvm, conda, juliaup, …) and aliases                  |

Installers such as `conda init` or juliaup append to `~/.zshrc`, which is a symlink into this repo. Check `git diff` before committing, and move anything machine-specific into `~/.zshrc.local`.
