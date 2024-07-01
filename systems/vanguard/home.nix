import ./modules/home.nix {
  username = "jens";
  homeDirectory = "/Users/Jens";
  ssh = {
    public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEG0u2sQkfE5QvH8xv7ZaY4lvca3aAZQX1cljJmNsNqx jens@vanguard";
    extraOptions = {
      UseKeychain = "yes";
    };
    hosts = {
      "github.com" = {
        identityFile = "~/.ssh/id_ed25519";
      };

      ubuntu = {
        hostname = "127.0.0.1";
        port = 2001;
        user = "jens";
        forwardAgent = true;
      };
    };
  };
}
