{
  signatures,
  signing_key,
}: {lib, ...}: {
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
        signingKey = signing_key;
      };

      gpg = {
        format = "ssh";
        ssh = {
          allowedSignersFile = "~/.config/git/allowed_signers";
        };
      };

      commit = {
        gpgsign = true;
      };

      tag = {
        gpgsign = true;
      };

      push = {
        autoSetupRemote = true;
        followTags = true;
      };

      pull = {
        rebase = false;
      };
    };
  };

  home.file = {
    ".config/git/allowed_signers" = {
      text =
        builtins.concatStringsSep
        "\n"
        (
          lib.attrsets.mapAttrsToList
          (key: value: "mail@jensmeindertsma.com ${value.key} ${value.username}@${key}")
          signatures
        );
    };
  };
}
