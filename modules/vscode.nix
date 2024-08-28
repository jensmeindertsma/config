{
  createDesktopEntry ? true,
  colorTheme,
  library,
}: {
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [alejandra nil];

  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    mutableExtensionsDir = true;
    extensions = with library; [
      vscode-marketplace.dbaeumer.vscode-eslint
      vscode-marketplace.enkia.tokyo-night
      vscode-marketplace.esbenp.prettier-vscode
      vscode-marketplace.github.vscode-github-actions
      vscode-marketplace.jnoortheen.nix-ide
      vscode-marketplace.jdinhlife.gruvbox
      vscode-marketplace.mkhl.direnv
      vscode-marketplace.ms-azuretools.vscode-docker
      vscode-marketplace.prisma.prisma
      vscode-marketplace.rust-lang.rust-analyzer
      vscode-marketplace.skellock.just
      vscode-marketplace.tamasfe.even-better-toml
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
        serverPath = "nil";
        serverSettings = {
          nil = {
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
        preferredDarkColorTheme = colorTheme.dark;
        preferredLightColorTheme = colorTheme.light;
        startupEditor = "none";
      };

      "[dockercompose]" = {
        editor.defaultFormatter = "ms-azuretools.vscode-docker";
      };

      "[nix]" = {
        editor.defaultFormatter = "jnoortheen.nix-ide";
      };
    };
  };

  xdg.desktopEntries =
    if createDesktopEntry == true
    then {
      code = {
        name = "Visual Studio Code";
        exec = "env SSH_AUTH_SOCK=/run/user/1001/ssh-agent ELECTRON_OZONE_PLATFORM_HINT=wayland code %F";
      };
    }
    else {};
}
