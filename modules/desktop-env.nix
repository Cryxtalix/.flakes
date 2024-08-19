{ config, lib, pkgs, ... }:
with lib;
{
  options.modules.gnome = {
    enable = mkEnableOption "Enables the GNOME desktop environment";
    gsconnect.enable = mkEnableOption "Enables KDEconnect for GNOME Desktops";
  };

  config = mkMerge [
    (mkIf config.modules.gnome.enable {
      # Enable the GNOME Desktop Environment.
      services.xserver = {
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };

      environment.gnome.excludePackages = with pkgs; [
        gnome.gnome-contacts
        gnome.gnome-maps
        gnome.gnome-music
        gnome.gnome-weather
        gnome-tour
        nixos-render-docs
        epiphany
        geary
        totem
        yelp
        simple-scan
        snapshot
      ];

      # Check https://userbase.kde.org/KDEConnect#Troubleshooting
      programs.kdeconnect = mkIf config.modules.gnome.gsconnect.enable {
        enable = true;
        package = pkgs.gnomeExtensions.gsconnect;
      };
    })
  ];
}
