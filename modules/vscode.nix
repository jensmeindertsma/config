{
  source,
  destination,
}: {
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [alejandra nixd];

  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      dbaeumer.vscode-eslint
      enkia.tokyo-night
      esbenp.prettier-vscode
      github.vscode-github-actions
      jnoortheen.nix-ide
      mkhl.direnv
      ms-azuretools.vscode-docker
      ms-vscode-remote.remote-ssh
      rust-lang.rust-analyzer
      skellock.just
      tamasfe.even-better-toml
    ];
    userSettings = {
      editor = {
        codeActionsOnSave = {
          source.fixAll = "always";
        };
        codeLens = false;
        fontFamily = "'JetBrainsMono Nerd Font', monospace";
        fontLigatures = true;
        fontSize = 18;
        formatOnSave = true;
        inlayHints.enabled = "offUnlessPressed";
        minimap.enabled = false;
        stickyScroll.enabled = false;
      };

      explorer = {
        confirmDelete = false;
        confirmDragAndDrop = false;
      };

      git = {
        autofetch = true;
        confirmSync = false;
        suggestSmartCommit = false;
      };

      nix = {
        enableLanguageServer = true;
        formatterPath = "alejandra";
        serverPath = "nixd";
        serverSettings = {
          nixd = {
            formatting = {
              command = ["alejandra"];
            };
          };
        };
      };

      rust-analyzer.check.command = "clippy";
      rust-analyzer.cargo.features = "all";

      security.workspace.trust.untrustedFiles = "open";

      terminal = {
        integrated = {
          fontSize = 16;
          shellIntegration.enabled = false;
        };
      };

      window = {
        autoDetectColorScheme = true;
        commandCenter = false;
        menuBarVisibility = "toggle";
        titleBarStyle = "native";
      };

      workbench = {
        layoutControl.enabled = false;
        preferredDarkColorTheme = "Tokyo Night";
        preferredLightColorTheme = "Tokyo Night Light";
        startupEditor = "none";
      };

      "[dockercompose]" = {
        editor.defaultFormatter = "ms-azuretools.vscode-docker";
      };
    };
  };

  xdg.desktopEntries = {
    code = {
      name = "Visual Studio Code";
      exec = "env ELECTRON_OZONE_PLATFORM_HINT=wayland code %F";
    };
  };
}
