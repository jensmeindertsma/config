nix-vscode-extensions: {...}: {
  programs.vscode = {
    enable = true;

    extensions = with nix-vscode-extensions.extensions.aarch64-darwin; [
      open-vsx-release.rust-lang.rust-analyzer
      vscode-marketplace.arrterian.nix-env-selector
      vscode-marketplace.jdinhlife.gruvbox
      vscode-marketplace.jnoortheen.nix-ide
      vscode-marketplace.ms-python.python
      vscode-marketplace.charliermarsh.ruff
    ];

    userSettings = {
      editor.codeLens = false;
      editor.fontFamily = "'JetBrainsMono Nerd Font', monospace";
      editor.fontLigatures = true;
      editor.fontSize = 18;
      editor.formatOnSave = true;
      editor.inlayHints.enabled = "offUnlessPressed";
      editor.minimap.enabled = false;
      explorer.confirmDragAndDrop = false;
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
      rust-analyzer.check.command = "clippy";
      security.workspace.trust.untrustedFiles = "open";
      terminal.integrated.fontSize = 17;
      terminal.integrated.shellIntegration.decorationsEnabled = "never";
      window.autoDetectColorScheme = true;
      window.commandCenter = false;
      window.titleBarStyle = "native";
      window.zoomLevel = 0.1;
      workbench.layoutControl.enabled = false;
      workbench.preferredLightColorTheme = "Gruvbox Light Hard";
      workbench.preferredDarkColorTheme = "Gruvbox Dark Hard";
      workbench.startupEditor = "none";
    };
  };
}
