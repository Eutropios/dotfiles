# About system:
# Font used: Nerd Consolig
# Text editor: Neovim (see config repo)
# zsh plugin manager: ZimFW
# zsh plugins: autocomplete, syntax highlighting, atuin,
# zsh modules: vcs, zmv, compinit, bashcompinit, colors
# Distribution: Fedora Desktop 41
# Startup: systemd

# ---***---***---***---***---
# zmodload zsh/zprof

# general settings
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
HISTDUP=erase
setopt autocd beep extendedglob nomatch menu_complete prompt_subst
setopt appendhistory hist_ignore_all_dups hist_ignore_dups hist_save_no_dups hist_find_no_dups hist_ignore_space
unsetopt notify
bindkey -v
bindkey '^[[Z' reverse-menu-complete

# changing completion settings
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle :compinstall filename '/home/noahj/.zshrc'

# setting histfile location
export HISTFILE="$XDG_STATE_HOME/zsh/history"

# loading modules
autoload -Uz compinit vcs_info
autoload -U zmv bashcompinit colors && colors

# modifying compinit
fpath+=~/.zfunc

compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
bashcompinit

# ---- Prompt configuration ----
# VCS info
precmd_vcs_info() {
    vcs_info
}
precmd_functions+=(precmd_vcs_info)
RPROMPT=\$vcs_info_msg_0_
# PROMPT=\$vcs_info_msg_0_'%# '
zstyle ':vcs_info:git:*' formats '%b'
# End of VCS info

# Prompt colouring
PROMPT='%B%F{green}%n%f%b@%B%F{cyan}%m%f%b:%B%F{blue}%~%f%b$ '

# The equivalent string for Bash terminals:
# \[\033[1;32m\]\u\[\033[1;37m\]@\[\033[1;36m\]\h\[\033[00m\]:\[\033[1;34m\]\w\[\033[00m\]\$

# ---- End of prompt configuration ----

# ---- ZimFW config ----

ZIM_HOME="${HOME}/.zim"
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
    source ${ZIM_HOME}/zimfw.zsh init
fi

# Initialize modules
# shellcheck disable=SC1091
. "${ZIM_HOME}/init.zsh"

# ZimFW plugin configs
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[alias]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=yellow,bold'

## To have paths colored instead of underlined
ZSH_HIGHLIGHT_STYLES[path]='fg=white,bold'

# --- End of ZimFW config ---

# Some programs require exporting in zshrc, or at least prefer it

# pnpm
export PNPM_HOME="/home/noahj/.local/share/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Aliases
alias cat="bat"                         # aliasing cat to bat
alias cls="clear"                       # Windows version of clear
alias diff="delta"                      # better diff
alias ds="dust -X /mnt -X /usr/lib/wsl" # give dust a shorter name
alias du="du -h --max-depth=1"          # set default for du command
alias find="fd"                         # better find
alias grep="rg"                         # make grep to use ripgrep
alias ls="lsd"                          # easier lsd alias
alias pypy="pypy3"                      # ensuring pypy3 usage
alias python="python3"                  # ensuring python3 usage
alias vim="nvim"                        # ensuring usage of neovim
alias zim="zimfw"                       # zimfw package manager for zsh
alias zj="zellij"                       # give zellij a shorter name
