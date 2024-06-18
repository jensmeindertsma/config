nix-vscode-extensions: {pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
    nil
    ruff
    rust-analyzer
  ];

  programs.vscode = {
    enable = true;

    extensions = with nix-vscode-extensions.extensions.aarch64-darwin; [
      open-vsx-release.rust-lang.rust-analyzer
      vscode-marketplace.charliermarsh.ruff
      vscode-marketplace.esbenp.prettier-vscode
      vscode-marketplace.github.github-vscode-theme
      vscode-marketplace.jdinhlife.gruvbox
      vscode-marketplace.jnoortheen.nix-ide
      vscode-marketplace.mkhl.direnv
      vscode-marketplace.ms-python.python
      vscode-marketplace.ms-vscode-remote.remote-ssh
      vscode-marketplace.usernamehw.errorlens
      vscode-marketplace.skellock.just
      vscode-marketplace.tamasfe.even-better-toml
    ];

    userSettings = {
      editor.codeActionsOnSave.source.fixAll = "enabled";
      editor.codeLens = false;
      editor.fontFamily = "'JetBrainsMono Nerd Font Mono', monospace";
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
}
