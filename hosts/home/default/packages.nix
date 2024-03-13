{ pkgs, pkgs_unstable, user, is_nixos, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    arduino
    chromium
    dconf
    ddrescue
    discord
    distrobox
    element-desktop
    ffmpeg
    firefox
    pkgs_unstable.foliate
    gittyup
    gnome.gnome-boxes
    gnome.gnome-tweaks
    htop
    libreoffice
    libvirt
    lutris
    marker
    neofetch
    nerdfonts
    nurl
    p7zip
    podman
    python3
    qbittorrent-qt5
    qemu
    realvnc-vnc-viewer
    telegram-desktop
    trayscale
    unrar
    virt-manager
    vlc
    vscode
    wineWowPackages.stable
    winetricks
    xivlauncher
  ] 
  ++ 
  (if is_nixos then with pkgs; [
    # Only when NixOS
    virtualbox
  ]
  else with pkgs; [
    # Only when not NixOS
    sops
    wget
  ]);
}