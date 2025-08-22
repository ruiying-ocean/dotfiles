#!/bin/zsh

# ============================================================================
# Zinit initialisation
# ============================================================================

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


# ============================================================================
# Zinit extensions
# ============================================================================
# Load completions first
zi light zsh-users/zsh-completions
autoload -U compinit && compinit

# Load plugins (removed duplicate pure theme loading)
zinit for \
      light-mode \
      zsh-users/zsh-autosuggestions \
      light-mode \
      zdharma-continuum/fast-syntax-highlighting \
      zdharma-continuum/history-search-multi-word

# Load theme
zi light geometry-zsh/geometry

# ============================================================================
# History 
# ============================================================================

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# ============================================================================
# ZSH OPTIONS
# ============================================================================

setopt AUTO_CD
setopt AUTO_LIST
setopt AUTO_MENU
setopt AUTO_PARAM_SLASH
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt GLOB_COMPLETE
setopt LIST_AMBIGUOUS
setopt MENU_COMPLETE

setopt CORRECT
setopt INTERACTIVE_COMMENTS

unsetopt FLOW_CONTROL
unsetopt MENU_COMPLETE

# ============================================================================
# KEYBINDINGS
# ============================================================================

bindkey '^[[C' autosuggest-accept

# ============================================================================
# ALIAS
# ============================================================================

alias ed="emacs --daemon"
alias ec="emacsclient -c"
alias eq="emacsclient -e '(save-buffers-kill-emacs)'"


# ============================================================================
# MODERN TOOLS
# ============================================================================
zinit ice from"gh-r" as"program"
zinit load junegunn/fzf

zinit ice from"gh-r" as"program"
zinit load ajeetdsouza/zoxide

zinit ice from"gh-r" as"program"
zinit load eza-community/eza

zinit ice from"gh-r" as"program"
zinit load sharkdp/bat

zinit ice from"gh-r" as"program"
zinit load sharkdp/fd

zinit ice from"gh-r" as"program"
zinit load BurntSushi/ripgrep

zinit ice from"gh-r" as"program"
zinit load dandavison/delta

zinit ice from"gh-r" as"program"
zinit load bootandy/dust

zinit ice from"gh-r" as"program"
zinit load astral-sh/uv

zinit ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zinit load tj/git-extras

# Initialize tools after loading
zinit wait lucid for \
      as"program" has"fzf" \
      atinit"source <(fzf --zsh)" \
      zdharma-continuum/null \
      as"program" has"zoxide" \
      atinit"eval \"\$(zoxide init zsh)\"" \
      zdharma-continuum/null

# Tool configurations and aliases
if (( $+commands[fzf] )); then
    export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --ansi --preview-window=right:60%'
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git --exclude node_modules'
    export FZF_CTRL_R_OPTS='--preview "echo {}" --preview-window down:3:hidden:wrap --bind "?:toggle-preview"'
fi

if (( $+commands[zoxide] )); then
    alias cd='z'
    alias cdi='zi'
fi

if (( $+commands[eza] )); then
    alias ll='eza -la --icons --group-directories-first --git'
    alias la='eza -a --icons --group-directories-first'
    alias lt='eza --tree --icons --level=2'
    alias ltl='eza --tree --icons --level=3 -l'
    alias ls='eza --icons --group-directories-first'
fi

if (( $+commands[bat] )); then
    alias batl='bat --style=numbers,changes'
    export BAT_THEME="Catppuccin-mocha"
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

if (( $+commands[fd] )); then
    alias find='fd'
fi

if (( $+commands[rg] )); then
    export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
fi

if (( $+commands[delta] )); then
    export GIT_PAGER='delta'
fi

if (( $+commands[dust] )); then
    alias du='dust'
fi

# ============================================================================
# MISC
# ============================================================================

skip_global_compinit=1

