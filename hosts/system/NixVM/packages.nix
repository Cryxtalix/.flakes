{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    home-manager
    sops
    wget
  ];

  services = {
    switcherooControl.enable = true;
    spice-webdavd.enable = true;
    spice-vdagentd.enable = true;
    printing.enable = false;
    xserver = {
      enable = true;
      # Keyboard
      xkb = {
        layout = "us";
        variant = "";
      };
      # Mouse and touchpad
      # Let DE auto configure
      /* libinput = {
        enable = true;
        touchpad.tapping = true;
      }; */

      excludePackages = [ pkgs.xterm ];
    };
  };

  virtualisation = {
    podman.enable = true;
  };
}
