default:
  just --list

switch-anna:
    home-manager switch --flake .#anna

switch-vanguard: 
    darwin-rebuild switch --flake .#vanguard

switch-wyvern:
    home-manager switch --flake .#wyvern

