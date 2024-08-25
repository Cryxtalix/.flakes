/* 
Install vim and import configuration from github repo 
*/

{ pkgs, ... }:
  let
    vim = pkgs.fetchFromGitHub{
      owner = "Cryxtalix";
      repo = ".vim";
      rev = "";
      sha256 = "";
    };
  in
{
  programs.vim = {
    enable = true;
    package = pkgs.vim-configurable;
    defaultEditor = true;
  };

  home.file = {
    ".vim/" = {
      source = "${vim}";
      recursive = true;
    };
  };
}
