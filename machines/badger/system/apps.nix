{...}: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    taps = [];
    brews = [];

    casks = [
      "aldente"
      "bitwarden"
      "discord"
      "docker"
      "firefox"
      "google-chrome"
      "hot"
      "iterm2"
      "notion"
      "microsoft-teams"
      "monitorcontrol"
      "protonvpn"
      "proton-drive"
      "protonmail-bridge"
      "signal"
      "spotify"
      "utm"
      "whatsapp"
    ];

    masApps = {
      "QuickShade" = 931571202;
    };
  };
}
