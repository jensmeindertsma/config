default:
  just --list

# TODO: add `switch` command that checks for the system using uname

switch-anna:
    sudo nixos-rebuild switch --flake .

switch-vanguard: 
    darwin-rebuild switch --flake .

switch-wyvern:
    sudo nixos-rebuild switch --flake .

