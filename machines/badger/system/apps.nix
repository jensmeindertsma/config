{...}: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    taps = [];
    brews = [];

    casks = [
    ];

    masApps = {
    };
  };
}
