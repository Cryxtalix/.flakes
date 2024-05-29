# Installing nix package manager on another distro
We can still get a lot of the reproducibility of NixOS on other distros simply by installing Nix, not as the operating system but as a third party package manager. Together with **Home Manager**, we can configure almost any user apps and make any changes to files and folders in the home folder.

1. Install the Nix package manager with install script from [https://zero-to-nix.com/start/install](https://zero-to-nix.com/start/install):
    `curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install`.

2. Restart shell and add home-manager channel:
`nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager`

3. Update nix-channels: 
`nix-channel --update`

4. Install home-manager: 
`nix-shell '<home-manager>' -A install`

5. Create folder: 
`mkdir ~/.config/nix`

6. Create config file: 
`echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf`

7. Download this configuration: 
`git clone https://github.com/Cryxtalix/NixOS-config && cd ~/NixOS-config`
Or follow the link and download the files manually and unzip.

8. Change the configuration to your liking, such as changing settings in /packages/git.nix, editing installed apps in `/hosts/home/profile`, or even creating new profiles! Be sure to add any new profiles in flake.nix. If using sops-nix, place keyfile(e.g. keys.txt) in `.config/sops/age`.

9. `git add -A` if you used git clone earlier and created any new files.

10. Finally, install the configuration! 
`home-manager switch -b backup --flake .#<your-home-profile>`

## Setting up SSH and keys
1. `chmod 700 .ssh`
2. `touch .ssh/authorized_keys && chmod 600 .ssh/authorized_keys`
3. `chown -R $(whoami) ~/.gnupg/`
4. `find ~/.gnupg -type f -exec chmod 600 {} \; && find ~/.gnupg -type d -exec chmod 700 {} \;`