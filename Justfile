default:
  just --list

switch-isac:
    home-manager switch --flake .#isac

switch-vanguard: 
    darwin-rebuild switch --flake .#vanguard

switch-wyvern:
    home-manager switch --flake .#wyvern

