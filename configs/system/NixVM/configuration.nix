{ config, lib, pkgs, timezone, locale, username, hostname, ... }:

{
  # ---------------------------SYSTEM SETTINGS START---------------------------
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
  };

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = hostname; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = timezone;

  # Select internationalisation properties.
  i18n.defaultLocale = locale;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = locale;
    LC_IDENTIFICATION = locale;
    LC_MEASUREMENT = locale;
    LC_MONETARY = locale;
    LC_NAME = locale;
    LC_NUMERIC = locale;
    LC_PAPER = locale;
    LC_TELEPHONE = locale;
    LC_TIME = locale;
  };
  # ---------------------------SYSTEM SETTINGS END---------------------------

    # ---------------------------FIREWALL SETTINGS START---------------------------
  /* networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];
    allowedUDPPorts = [];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }
    ]
  }; */
  # ---------------------------FIREWALL SETTINGS END---------------------------

  # ---------------------------ADD USERS START---------------------------
  # Don't forget to set a password with ‘passwd’.
  users.users.cryxtalix = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" "podman" ];
  };
  # ---------------------------ADD USERS END---------------------------

  # ---------------------------DISPLAY OPTIONS START---------------------------
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    # Configure keymap in X11
    layout = "us";
    xkbVariant = "";
  };
  # ---------------------------DISPLAY OPTIONS END---------------------------

  # ---------------------------SOUND OPTIONS START---------------------------
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  # ---------------------------SOUND OPTIONS END---------------------------

  # ---------------------------MISC OPTIONS START---------------------------
  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  # ---------------------------MISC OPTIONS END---------------------------

  # ---------------------------PACKAGES START---------------------------
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    home-manager
    openssl
    wget
  ];

  # Program enable
  services = {
    #openssh.enable = true;
    switcherooControl.enable = true;
    spice-webdavd.enable = true;
    spice-vdagentd.enable = true;
  };
  virtualisation.podman = {
  	enable = true;
  	enableNvidia = true;
  };

  # Remove unwanted packages
  services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    nixos-render-docs
    gnome.epiphany
    gnome.geary
    gnome.seahorse
    gnome.totem
    gnome.yelp
    gnome.gnome-contacts
    gnome.gnome-maps
    gnome.gnome-music
    gnome.gnome-weather
    gnome.simple-scan
    snapshot
  ];
  # ---------------------------PACKAGES END---------------------------

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
