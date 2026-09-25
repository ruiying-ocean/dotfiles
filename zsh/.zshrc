#!/bin/zsh

# ============================================================================
# Zinit initialisation
# ============================================================================

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

typeset -U path   # zinit prepends plugin dirs; keep PATH free of duplicates

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


# ============================================================================
# Zinit extensions
# ============================================================================
# Load completions first
zi light zsh-users/zsh-completions
autoload -U compinit && compinit $ZSH_COMPINIT_FLAGS   # set to -u in ~/.zprofile.local if fpath has dirs owned by another account

# Load plugins (removed duplicate pure theme loading)
zinit for \
      light-mode \
      zsh-users/zsh-autosuggestions \
      light-mode \
      zdharma-continuum/fast-syntax-highlighting \
      zdharma-continuum/history-search-multi-word

# Load theme: Pure (async, pure-zsh prompt)
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

# ============================================================================
# History 
# ============================================================================

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
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

setopt CORRECT
setopt INTERACTIVE_COMMENTS

unsetopt FLOW_CONTROL

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
# CLI tools (fzf, zoxide, bat, fd, rg, delta, dust, uv, difft, eza) are
# installed with Homebrew — update them with `brew upgrade`.

# zoxide adds z alongside the built-in cd (no override). Its interactive
# picker is `zf`, since `zi` is taken by zinit's alias.
if (( $+commands[zoxide] )); then
    eval "$(zoxide init zsh)"
    alias zf='__zoxide_zi'
fi

# fzf keybindings (Ctrl-T, Ctrl-R, Alt-C) and completion
[[ -t 0 ]] && (( $+commands[fzf] )) && source <(fzf --zsh)

# Tool configurations and aliases
if (( $+commands[fzf] )); then
    export FZF_DEFAULT_OPTS='
      --height 40%
      --layout=reverse
      --border
      --ansi
      --preview-window=right:60%
      --color=fg:#d0d0d0,bg:#2e3440,hl:#87afff
      --color=fg+:#ffffff,bg+:#434c5e,hl+:#5fd7ff
      --color=info:#afafaf,prompt:#5fd7af,pointer:#ff5f5f
      --color=marker:#ffff5f,spinner:#af5fff,header:#87afaf
    '
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git --exclude node_modules'
    export FZF_CTRL_R_OPTS='--preview "echo {}" --preview-window down:3:hidden:wrap --bind "?:toggle-preview"'
fi

if (( $+commands[eza] )); then
    alias l='eza --icons --group-directories-first'
fi

if (( $+commands[bat] )); then
    alias batl='bat --style=numbers,changes'
    export BAT_THEME="Catppuccin Mocha"
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

if (( $+commands[delta] )); then
    export GIT_PAGER='delta'
fi

# ============================================================================
# MISC
# ============================================================================

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE="$HOME/miniforge3/bin/mamba";
export MAMBA_ROOT_PREFIX="${MAMBA_ROOT_PREFIX:-$HOME/miniforge3}";  # override in ~/.zprofile.local
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
alias vim=nvim
alias matlab="/Applications/MATLAB_R2025b.app/bin/matlab -nojvm -nodesktop"

# Machine-specific settings and secrets (not tracked)
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local
