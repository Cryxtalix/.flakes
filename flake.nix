{
  description = "MyFlake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      lib = nixpkgs.lib;
      configDir = "~/NixOS-config"; # Path of this file

      mkNixosConfigurations = hostname: system: lib.nixosSystem {
        inherit system;
        modules = [
          (./hosts/system/${hostname}/configuration.nix)
          inputs.sops-nix.nixosModules.sops
        ];
        specialArgs = {
          inherit timezone locale username hostname;
        };
      };

      mkHomeConfigurations = name: system: is_nixos: inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ 
          ./hosts/home/${name}/home.nix 
        ] 
        ++ 
        (if (!is_nixos) then [
          inputs.sops-nix.homeManagerModules.sops
        ] else []);
        extraSpecialArgs = {
          pkgs_unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
          inherit username configDir is_nixos;
        };
      };

      timezone = "Asia/Singapore";
      locale = "en_SG.UTF-8";
      username = "cryxtalix";
    in
  {
    nixosConfigurations = {
      swift3 = mkNixosConfigurations "AcerSwift3" "x86_64-linux";
      nixvm = mkNixosConfigurations "NixVM" "x86_64-linux";  
    };

    homeConfigurations = {
      os_default = mkHomeConfigurations "default" "x86_64-linux" true;
      default = mkHomeConfigurations "default" "x86_64-linux" false;
      os_minimal = mkHomeConfigurations "minimal" "x86_64-linux" true;
      minimal = mkHomeConfigurations "minimal" "x86_64-linux" false;
    };

    # Development environments
    c = import ./dev-envs/c.nix {pkgs = nixpkgs.legacyPackages."x86_64-linux";};
    python = import ./dev-envs/python.nix {pkgs = nixpkgs.legacyPackages."x86_64-linux";};
    esp = import ./dev-envs/esp.nix {pkgs = nixpkgs.legacyPackages."x86_64-linux";};
  };
}