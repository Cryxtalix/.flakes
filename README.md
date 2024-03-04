# My NixOS Configuration
My configuration uses flakes and standalone Home-Manager. In order to support multiple machines and profiles, my code prioritises modularity and reusable code. Sops-nix is used to handle secrets such as user passwords and wifi credentials.

This document will document some features of the config.

## Index
[Helpful bash aliases](Documentation/bash_aliases.md)

[Installing Nix package manager on other distros](Documentation/installing_nix_pm.md)

[Running an SSH git server](Documentation/git_server.md)