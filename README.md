# configuration

All my configuration for all my systems (excluding Windows, duh!) in one place!

Nix is love, Nix is life

## Hosts

### Badger

- `nix-darwin` will register shells provided to `environment.shells` in `/etc/shells`, which will allow a shell to be set as a login shell, but it won't set a shell as a login shell for you. You have to do this yourself with `chsh -s /run/current-system/sw/bin/zsh` (replace `zsh` with whatever shell you want to use, provided you have configured it as described above).
