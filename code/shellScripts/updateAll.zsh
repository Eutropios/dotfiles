#!/usr/bin/env zsh

# pip
# luarocks

. "$HOME"/.zim/init.zsh

echo "Updating zimfw...\n"
zimfw update

echo "\nUpdating cargo crates..."
cargo-install-update install-update --all

echo "\nChecking for Rust toolchain updates..."
rustup update

echo "\nUpdating pipx scripts"
pipx upgrade-all

echo "\nUpdating pnpm packages"
pnpm -g upgrade

echo "\nPerforming dnf upgrade. Be prepared to enter your password."
sudo dnf upgrade
