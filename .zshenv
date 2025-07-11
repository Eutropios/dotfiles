export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Creating a path if it doesn't exist
if ! [[ $PATH =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

# Add Mason tools to path
PATH="$HOME/.local/share/nvim/mason/bin/:$PATH"

# Add shell scripts
PATH="$HOME/code/shellScripts/:$PATH"

# --- Version managers, Toolchains, and Language directories ---

# Configuring Go
PATH="$PATH:/usr/local/go/bin"
export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$HOME/.local/bin/go"

# Configuring Zig
export PATH="$PATH:$HOME/code/langs/zig"

# shellcheck disable=SC1091
. "$HOME/.cargo/env"

# perl envvars
export PATH="/home/noahj/.perl5/bin${PATH:+:${PATH}}"
export PERL5LIB="/home/noahj/.perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="/home/noahj/.perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT='--install_base "/home/noahj/.perl5"'
export PERL_MM_OPT="INSTALL_BASE=/home/noahj/.perl5"

# changing rubygems output dirs (see ~/.gemrc)
export GEM_HOME=$HOME/.gem
export GEM_PATH=$HOME/.gem

# forcing usage of venv to install with pip
export PIP_REQUIRE_VIRTUALENV=true
# adding pythonhist envvar
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"

# assigning zimfw home variable before being called in ~/.zshrc
export ZIM_HOME="$HOME/.zim"

# Adding luarocks to path
eval "$(luarocks path)"

# adding ghcup to path
[ -f "/home/noahj/.ghcup/env" ] && . "/home/noahj/.ghcup/env"

export GHCUP_USE_XDG_DIRS=true

export STACK_XDG=1
export CALCHISTFILE="$XDG_CACHE_HOME"/calc_history
