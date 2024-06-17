{...}: {
  programs.git = {
    enable = true;

    userName = "Jens Meindertsma";
    userEmail = "mail@jensmeindertsma.com";

    aliases = {
      setup = "!git commit --allow-empty -m 'Initial commit' && git push";
    };

    extraConfig = {
      init = {
        defaultBranch = "main";
      };

      user = {
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEG0u2sQkfE5QvH8xv7ZaY4lvca3aAZQX1cljJmNsNqx";
      };

      push = {
        autoSetupRemote = true;
        followTags = true;
      };

      pull = {
        rebase = false;
      };

      gpg = {
        format = "ssh";
        ssh = {
          allowedSignersFile = "/Users/Jens/.config/git/allowed_signers";
        };
      };

      commit = {
        gpgsign = true;
      };

      tag = {
        gpgsign = true;
      };
    };
  };

  home.file = {
    ".config/git/allowed_signers" = {
      text = ''
        mail@jensmeindertsma.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEG0u2sQkfE5QvH8xv7ZaY4lvca3aAZQX1cljJmNsNqx
      '';
    };
  };
}
