#! /bin/bash
# ONLY FOR FIRST TIME INSTALLING NIX PACKAGE MANAGER!
# Installs Nix package manager and home-manager
# Installs minimal home-manager config

sh <(curl -L https://nixos.org/nix/install) --no-daemon &&
nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager &&
nix-channel --update &&
nix-shell '<home-manager>' -A install &&
mkdir ~/.config/nix &&
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf &&
cd ~/NixOS-config &&
home-manager switch -b backup --flake .#minimal