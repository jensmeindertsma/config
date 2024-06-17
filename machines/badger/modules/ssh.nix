{...}: {
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host github.com
        IdentityFile    ~/.ssh/id_ed25519
        AddKeysToAgent  yes
        UseKeychain     yes

      Host ubuntu
        HostName        127.0.0.1
        Port            2001
        User            jens
        ForwardAgent    yes
        AddKeysToAgent  yes
        UseKeychain     yes
    '';
  };
}
