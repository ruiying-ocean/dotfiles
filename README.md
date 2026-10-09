# Dotfiles

This repository contains my personal dotfiles for configuring various tools and applications.

## Setup

```sh
git clone git@github.com:ruiying-ocean/dotfiles.git ~/dotfiles && ~/dotfiles/install.sh
```

`install.sh` symlinks the files into `$HOME`; any real file already there is backed up to `<name>.bak.<timestamp>`.

`Brewfile` lists CLI tools and apps, including global npm tools with `npm "package-name"` entries. The npm entries use the npm on `PATH`; when using nvm, activate the intended Node version first. zinit (bootstrapped by `.zshrc`) only manages zsh plugins and the Pure prompt.

```sh
brew bundle --file=~/dotfiles/Brewfile                 # install
brew bundle dump --file=~/dotfiles/Brewfile --force    # refresh after installing something new
```

Keep each tool under one installer: Codex, Copilot, and the Bash, Python, and YAML language servers are npm entries. Claude Code uses its [native installer](https://code.claude.com/docs/en/setup#install-claude-code) and updates separately. npm and Corepack are managed with the Node installation rather than listed here.

Project libraries belong in that project's `package.json` and `package-lock.json`. Avoid a catch-all `~/package.json`: npm can pick it up from unrelated subfolders. To add a machine-wide npm tool, add an `npm` entry to `Brewfile` and run `brew bundle`.

## Git

`git/.gitconfig` uses delta as the pager. For syntax-aware diffs from difftastic, use `git dft`, `git dlog` and `git dshow`.

## Neovim

`nvim/` is a [LazyVim](https://www.lazyvim.org) config, linked to `~/.config/nvim`. Plugins install themselves on first launch at the versions pinned in `nvim/lazy-lock.json`; commit that file after `:Lazy update`. `vim/.vimrc` is only for plain `vim`, which Neovim does not read.

## Agent skills

Skills for Codex and Claude Code live in their own private repo, cloned as `~/.agents`:

```sh
git clone git@github.com:ruiying-ocean/agent-skills.git ~/.agents && ~/.agents/sync.sh
```

`sync.sh` downloads the third-party skills listed in `Skillfile` and links every skill into `~/.claude/skills`. To pick up changes later, run `git -C ~/.agents pull && ~/.agents/sync.sh`. That repo's README covers the rest.

## Machine-specific config

The repo holds only what is shared by every machine. Anything that belongs to one machine, including secrets, goes in untracked files, which the tracked ones source at the end:

| File                | For                                                                    |
| ------------------- | ---------------------------------------------------------------------- |
| `~/.zprofile.local` | PATH entries, env vars, API keys, overrides (`MAMBA_ROOT_PREFIX`, `ZSH_COMPINIT_FLAGS=-u` when Homebrew is owned by another account) |
| `~/.zshrc.local`    | interactive hooks (nvm, conda, juliaup, …) and aliases                  |

Installers such as `conda init` or juliaup append to `~/.zshrc`, which is a symlink into this repo. Check `git diff` before committing, and move anything machine-specific into `~/.zshrc.local`.
