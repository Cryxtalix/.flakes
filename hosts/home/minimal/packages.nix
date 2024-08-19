{ pkgs, user, is_nixos, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    distrobox
    podman
    unar
  ]
  ++
  (if is_nixos then with pkgs; [
    # Only when NixOS
    firefox
  ]
  else with pkgs; [
    # Only when not NixOS
    sops
    wget
  ]);
}
