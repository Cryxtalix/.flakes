{ config, pkgs, pkgs_unstable, username, is_nixos, configDir, ... }:

{
  imports = [
    ../../../packages
  ];

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true; # Do not change
  targets.genericLinux.enable = if is_nixos then false else true;

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "23.11"; # Do not change

    packages = with pkgs; [
      distrobox
      firefox
      podman
      sops
    ];

    file = {
      # dotfiles
    };

    sessionVariables = {
      # EDITOR = "emacs";
    };
  };
}
