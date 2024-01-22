{
  description = "MyFlake";

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:

    let
    /* 
    DO NOT KEEP PASSWORDS AND API KEYS HERE! Use proper secrets encryption like:
    sops-nix: https://github.com/Mic92/sops-nix
    OR
    agenix: https://github.com/ryantm/agenix
    */
      # System settings
      lib = nixpkgs.lib;
      pkgs = import nixpkgs { inherit system; };
      unstable = import nixpkgs-unstable { inherit system; };
      system = "x86_64-linux";
      timezone = "Asia/Singapore";
      locale = "en_SG.UTF-8";

      # User settings
      username = "cryxtalix";
      configDir = "~/NixOS-config"; # Path of this file
    in

  {
    nixosConfigurations = {

      swift3 = lib.nixosSystem {
        inherit system;
        modules = [
          (./configs/system/AcerSwift3/configuration.nix)
        ];
        specialArgs = {
          inherit timezone;
          inherit locale;
          inherit username;
          hostname = "AcerSwift3";
        };
      };
    };

    homeConfigurations = {

      default-nixos = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          (./configs/home/default/home.nix)
        ];
        extraSpecialArgs = {
          inherit unstable;
          inherit username;
          inherit configDir;
          is_nixos = true;
          home_profile = "default-nixos";
        };
      };

      default = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          (./configs/home/default/home.nix)
        ];
        extraSpecialArgs = {
          inherit unstable;
          inherit username;
          inherit configDir;
          is_nixos = false;
          home_profile = "default";
        };
      };
    };

    # Development environments
    c = import ./dev-envs/c.nix { inherit self pkgs; };
    python = import ./dev-envs/python.nix { inherit self pkgs; };
    esp = import ./dev-envs/esp.nix { inherit self pkgs; };

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
	  };
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

}
