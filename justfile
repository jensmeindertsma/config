default:
  just --list

switch-anna:
    sudo nixos-rebuild switch --flake .

switch-vanguard: 
    darwin-rebuild switch --flake .#vanguard

switch-wyvern:
    home-manager switch --flake .#wyvern

