{ pkgs, user, is_nixos, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    arduino
    chromium
    element-desktop
    ffmpeg
    foliate
    gittyup
    gnome.gnome-boxes
    gnome-tweaks
    hexchat
    htop
    impression
    libvirt
    marker
    neofetch
    p7zip
    qbittorrent-qt5
    qemu
    scrcpy
    stellarium
    telegram-desktop
    trayscale
    unar
    virt-manager
    vlc
    webcord
  ] 
  ++ 
  (if is_nixos then with pkgs; [
    # Only when NixOS
    distrobox
    firefox
    libreoffice
    lutris
    podman
    python3
    vscode-fhs
    winetricks
    wineWowPackages.stable
    xivlauncher
  ]
  else with pkgs; [
    # Only when not NixOS
    gnomeExtensions.gsconnect
    sops
    wget
  ]);
}
