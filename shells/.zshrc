# About system:
# Font used: Jetbrains Mono
# Text editor: Neovim (see config repo)
# zsh plugin manager: ZimFW
# zsh plugins: autocomplete, syntax highlighting
# Distribution: Fedora Desktop 38
# Startup: systemd

# ---***---***---***---***---

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd beep extendedglob nomatch histignoredups menu_complete
unsetopt notify
bindkey -v
bindkey '^[[Z' reverse-menu-complete
# End of lines configured by zsh-newuser-install

# Lines added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle :compinstall filename '/home/noahj/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# --- ZimFW config ---
ZIM_HOME=~/.zim

# Download zimfw plugin manager if missing
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
	curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
		https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
	. ${ZIM_HOME}/zimfw.zsh init -q
fi

# Initialize modules.
. ${ZIM_HOME}/init.zsh

# ZimFW plugin configs
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[alias]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=yellow,bold'

# To have paths colored instead of underlined
ZSH_HIGHLIGHT_STYLES[path]='fg=white,bold'

# --- End of ZimFW config ---

# ---***---***---***---***---***---***---***---***---***---***---

# --- Aliases, Manual PATH Additions, and Prompt Colouring ---

# Creating a path if it doesn't exist
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
	PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

# pnpm
export PNPM_HOME="/home/noahj/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Add ~/Tools/ to PATH
PATH="$HOME/Tools/:$PATH"

# Add Mason tools to path
PATH="$HOME/.local/share/nvim/mason/bin/:$PATH"

# --- Version managers, Toolchains, and Language directories ---
# Lines added by Go
export PATH="$PATH:/usr/local/go/bin"
export GOPATH="$HOME/Code/go"
# End of lines added by Go

. "$HOME/.cargo/env"

# Aliases
if [ -f "$HOME/.zsh_aliases" ]; then
	. "$HOME/.zsh_aliases"
fi

# Prompt coloring
autoload -U colors && colors
PROMPT='%B%F{green}%n%f%b@%B%F{cyan}%m%f%b:%B%F{blue}%~%f%b$ '
# The equivalent string for Bash terminals
# \[\033[1;32m\]\u\[\033[1;37m\]@\[\033[1;36m\]\h\[\033[00m\]:\[\033[1;34m\]\w\[\033[00m\]\$
