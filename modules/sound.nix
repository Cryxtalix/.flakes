{ config, lib, pkgs, ... }:
with lib;
{
  options.modules = {
    sound = {
      enable = mkEnableOption "Enable sound";
      jack.enable = mkEnableOption "Enables jack";
    };
  };

  config = mkIf config.modules.sound.enable {
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = if config.modules.sound.jack.enable then true else false;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
  };
}
