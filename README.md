# My NixOS Configuration
Uses standalone home-manager and flakes.

## To update flake:
*Fetches latest versions of nixpkgs and dependencies*

$ `nix-flake-up`

## To upgrade system packages:
$ `nix-system-up`

## To upgrade home packages:
$ `nix-home-up`

## Or to update and upgrade entire system:
$ `nix-full-up`

## To start development environment:
*Convenient env, use dev templates for project specific envs*

$ `nix-dev <choice_of_language>`

# For nix package manager on another distro:
1. Install nix using the system package manager
2. Add home-manager channel: `nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager`
3. Update nix-channels: `nix-channel --update`
4. Install home-manager: `nix-shell '<home-manager>' -A install`
5. Go to ~/.config/nix/ creating the folders if they do not exist
6. Create config file with ` echo "experimental-features = nix-command flakes" >> nix.conf`
7. Clone this repo, cd into it and open flake.nix in a text editor. Change the attributes. Be sure to set `is_nixos = false;`
8. Run: `home-manager switch --flake .`