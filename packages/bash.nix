{ is_nixos, user, ... }:

{
  programs.bash = {
    enable = true;
    
    shellAliases = {
      ll = "ls -al";
      c = "clear";
      v = "vim";
      nix-flake-up = "(cd ${user.configDir} && nix flake update)";
      nv-watch = "watch -n1 nvidia-smi";
      get-idf = ". $HOME/esp/esp-idf/export.sh";
    } 
    // 
    (if is_nixos then {
      # Only when NixOS
      nix-cg = "sudo nix-collect-garbage --delete-older-than 7d";
    } 
    else {
      # Only when not NixOS
      nix-cg = "nix-collect-garbage --delete-older-than 7d";
    });

    sessionVariables = {

    };

    initExtra = ''
      export PS1='\[\e[1m\][ \[\e[96m\]\w \[\e[39m\]]\\$ \[\e[0m\]'
      nix-dev() {
        nix develop ${user.configDir}/.#"$1"
      }
      nix-home-up() {
        home-manager switch --flake ${user.configDir}/.#"$1"
      }
    ''
    +
    # Only when NixOS
    (if is_nixos then ''
      nix-system-up() {
        sudo nixos-rebuild switch --flake ${user.configDir}/.#"$1"
      }
      nix-full-up() {
        nix-flake-up && nix-system-up "$1" && nix-home-up "$2"
      }
    '' 
    # Only when not NixOS
    else ''
      nix-full-up() {
        nix-flake-up && nix-home-up "$1"
      }
    '');
  };
}
