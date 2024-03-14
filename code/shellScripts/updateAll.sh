#!/usr/bin/env bash

# pip
# luarocks
# Possible luarocks command: luarocks list --outdated --porcelain | cut -f1
# cpanm

# . "$HOME"/.zim/init.zsh

# printf "Updating zimfw..\n"
# zimfw update

NO_FORMAT="\033[0m"
C_TEAL="\033[38;5;6m"

update-script() {
    local cmdline="$1"
    local prog=${cmdline%% *}
    local progargs=${cmdline#* }
    if [[ $prog == sudo ]]; then
        prog=${progargs%% *}
    fi
    if [[ -n "$(command -v "$prog")" ]]; then
        echo -e "${C_TEAL}\$${NO_FORMAT} ${cmdline[*]}"
        sh -c "${cmdline[@]}"
    fi
}

declare -a updates=(
    "sudo dnf upgrade"
    "sudo dnf autoremove"
    "gem update"
    "gem cleanup"
    "rustup update"
    "cargo-install-update install-update all"
    "pnpm update -gL"
    "pipx upgrade-all"
)

for cmd in "${updates[@]}"; do
    update-script "$cmd"
done
