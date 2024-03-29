# Creating a path if it doesn't exist
if ! [[ $PATH =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
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

# Add shell scripts
PATH="$HOME/code/shellScripts/:$PATH"

# --- Version managers, Toolchains, and Language directories ---
# Lines added by Go
export PATH="$PATH:/usr/local/go/bin"
export GOPATH="$HOME/code/go"
# End of lines added by Go

# shellcheck disable=SC1091
. "$HOME/.cargo/env"

# perl envvars
PATH="/home/noahj/.perl5/bin${PATH:+:${PATH}}"
export PERL5LIB="/home/noahj/.perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="/home/noahj/.perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT='--install_base "/home/noahj/.perl5"'
export PERL_MM_OPT="INSTALL_BASE=/home/noahj/.perl5"

# unbinding atuin for rebinding in ~/.zshrc
export ATUIN_NOBIND="true"

# changing rubygems output dirs (see ~/.gemrc)
export GEM_HOME=$HOME/.gem
export GEM_PATH=$HOME/.gem

# forcing usage of venv to install with pip
export PIP_REQUIRE_VIRTUALENV=true

# assigning zimfw home variable before being called in ~/.zshrc
export ZIM_HOME="$HOME/.zim"

# Adding luarocks to path
eval "$(luarocks path)"
