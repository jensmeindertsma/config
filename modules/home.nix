{
  aliases,
  homeDirectory,
  ssh,
  username,
  imports,
}: {pkgs, ...}: {
  home = {
    stateVersion = "24.11";
    username = username;
    homeDirectory = homeDirectory;
  };

  nixpkgs.config.allowUnfree = true;

  # Let `home-manager` install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    alejandra
    bat
    btop
    cowsay
    dive
    doctl
    dua
    eza
    gh
    just
    license-generator
    neofetch
    neovim
    nil
    ripgrep
    ruff
    rust-analyzer
    tmux
  ];

  # TODO: configure bash and zsh completions with zinit and plugin, also change histfile and compdump
  # locations.
  programs.bash.enable = true;
  programs.zsh = {
    enable = true;
    shellAliases =
      {
        cat = "bat";
        el = "eza -l";
        ela = "eza -la";
        mit = "license-generator mit --author 'Jens Meindertsma' --output LICENSE.md";
      }
      // aliases;
  };

  programs.direnv = {
    enable = true;
    config = {
      warn_timeout = 0;
    };
  };

  programs.starship = {
    enable = true;
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = ssh.hosts;
  };

  services.ssh-agent.enable = true;

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
        signingKey = ssh.public_key;
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
          allowedSignersFile = "~/.config/git/allowed_signers";
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
        mail@jensmeindertsma.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEG0u2sQkfE5QvH8xv7ZaY4lvca3aAZQX1cljJmNsNqx jens@vanguard
        mail@jensmeindertsma.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJhI5sNxApLWYWOKljGuaVzt/6rsAVlAlb2lKv0nPHyD jens@wyvern
      '';
    };
  };

  programs.vscode = {
    enable = true;

    userSettings = {
      editor.codeActionsOnSave.source.fixAll = "enabled";
      editor.codeLens = false;
      editor.fontFamily = "'JetBrains Mono', monospace";
      editor.fontLigatures = true;
      editor.fontSize = 18;
      editor.formatOnSave = true;
      editor.inlayHints.enabled = "offUnlessPressed";
      editor.minimap.enabled = false;
      explorer.confirmDragAndDrop = false;
      git.autofetch = true;
      git.confirmSync = false;
      nix.enableLanguageServer = true;
      nix.serverPath = "nil";
      nix.serverSettings = {
        nil = {
          formatting = {
            command = ["alejandra"];
          };
        };
      };
      python.terminal.activateEnvironment = false;
      ruff.nativeServer = true;
      rust-analyzer.check.command = "clippy";
      security.workspace.trust.untrustedFiles = "open";
      terminal.integrated.fontSize = 17;
      terminal.integrated.shellIntegration.enabled = false;
      window.autoDetectColorScheme = true;
      window.commandCenter = false;
      window.titleBarStyle = "native";
      window.zoomLevel = 0.1;
      workbench.layoutControl.enabled = false;
      workbench.preferredLightColorTheme = "GitHub Light";
      workbench.preferredDarkColorTheme = "GitHub Dark";
      workbench.startupEditor = "none";
      "[json]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[jsonc]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[markdown]".editor.defaultFormatter = "esbenp.prettier-vscode";
      "[python]".editor.defaultFormatter = "charliermarsh.ruff";
    };
  };

  imports = imports;
}
