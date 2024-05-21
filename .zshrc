# About system:
# Font used: Nerd Consolig
# Text editor: Neovim (see config repo)
# zsh plugin manager: ZimFW
# zsh plugins: autocomplete, syntax highlighting, atuin,
# zsh modules: vcs, zmv, compinit, bashcompinit, colors
# Distribution: Fedora Desktop 39
# Startup: systemd

# ---***---***---***---***---
# zmodload zsh/zprof

# general settings
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd beep extendedglob nomatch histignoredups menu_complete prompt_subst
unsetopt notify
bindkey -v
bindkey '^[[Z' reverse-menu-complete

# changing completion settings
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle :compinstall filename '/home/noahj/.zshrc'

# loading modules
autoload -Uz compinit vcs_info
autoload -U zmv bashcompinit colors && colors

# modifying compinit
fpath+=~/.zfunc

compinit && bashcompinit

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

# Download zimfw plugin manager if missing
if [[ ! -e "${ZIM_HOME}/zimfw.zsh" ]]; then
    curl -fsSL --create-dirs -o "${ZIM_HOME}/zimfw.zsh" \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! "${ZIM_HOME}/init.zsh" -nt "${ZDOTDIR:-${HOME}}/.zimrc" ]]; then
    # shellcheck disable=SC1091
    source "${ZIM_HOME}/zimfw.zsh init -q"
fi

# Initialize modules
# shellcheck disable=SC1091
. "${ZIM_HOME}/init.zsh"

# ZimFW plugin configs
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[alias]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=yellow,bold'

# To have paths colored instead of underlined
ZSH_HIGHLIGHT_STYLES[path]='fg=white,bold'

# --- End of ZimFW config ---

# Aliases
alias cat="bat"                         # aliasing cat to bat
alias cls="clear"                       # Windows version of clear
alias diff="delta"                      # better diff
alias ds="dust -X /mnt -X /usr/lib/wsl" # give dust a shorter name
alias du="du -h --max-depth=1"          # set default for du command
alias find="fd"                         # better find
alias grep="rg"                         # make grep to use ripgrep
alias ls="lsd"                          # easier lsd alias
alias py="python3"                      # Windows version of python3
alias python="python3"                  # ensuring python3 usage
alias tree="erd"                        # better tree
alias vim="nvim"                        # ensuring usage of neovim
alias zim="zimfw"                       # zimfw package manager for zsh
alias zj="zellij"                       # give zellij a shorter name
