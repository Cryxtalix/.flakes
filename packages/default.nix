{ config, pkgs, ... }:

{
  imports = [
    ./bash.nix
    ./git.nix
    ./gnupg.nix
    ./neovim/install-only.nix
    ./nix-direnv.nix
  ];
}