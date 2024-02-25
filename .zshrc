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

# ---- Prompt configuration ----
# VCS info
autoload -Uz vcs_info
precmd_vcs_info() {
	vcs_info
}
precmd_functions+=(precmd_vcs_info)
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
# PROMPT=\$vcs_info_msg_0_'%# '
zstyle ':vcs_info:git:*' formats '%b'
# End of VCS info

# Prompt colouring
autoload -U colors && colors
PROMPT='%B%F{green}%n%f%b@%B%F{cyan}%m%f%b:%B%F{blue}%~%f%b$ '

# The equivalent string for Bash terminals:
# \[\033[1;32m\]\u\[\033[1;37m\]@\[\033[1;36m\]\h\[\033[00m\]:\[\033[1;34m\]\w\[\033[00m\]\$

# ---- End of prompt configuration ----

# ---- ZimFW config ----
ZIM_HOME="$HOME/.zim"

# Download zimfw plugin manager if missing
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
	curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
		https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
	# shellcheck disable=SC1091
	. ${ZIM_HOME}/zimfw.zsh init -q
fi

# Initialize modules
# shellcheck disable=SC1091
. ${ZIM_HOME}/init.zsh

# ZimFW plugin configs
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[alias]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=yellow,bold'

# To have paths colored instead of underlined
ZSH_HIGHLIGHT_STYLES[path]='fg=white,bold'

# --- End of ZimFW config ---

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

# Add update script
PATH="$HOME/code/shellScripts/:$PATH"

# --- Version managers, Toolchains, and Language directories ---
# Lines added by Go
export PATH="$PATH:/usr/local/go/bin"
export GOPATH="$HOME/code/go"
# End of lines added by Go

# shellcheck disable=SC1091
. "$HOME/.cargo/env"

# Aliases
if [ -f "$HOME/.zsh_aliases" ]; then
	# shellcheck disable=SC1091
	. "$HOME/.zsh_aliases"
fi

# Functions

# Blurs background of vertical videos in the directory
function blurbackground() {
	for a in *.mp4; do
		ffmpeg -i "$a" -filter_complex "[0:v]scale=ih*16/9:-1,boxblur=luma_radius=min(h\,w)/20:luma_power=1:chroma_radius=min(cw\,ch)/20:chroma_power=1[bg];[bg][0:v]overlay=(W-w)/2:(H-h)/2,crop=h=iw*9/16" "blurred$a"
		rm "$a"
	done
}

# Loop videos in directory for a specific time
function loopvideo() {
	for a in *.mp4; do
		ffmpeg -stream_loop -1 -i "$a" -c:v libx265 -tag:v hvc1 -movflags faststart -vf scale=1268:-2 -t "$1" "looped$a"
		rm -r "$a"
	done
}
