export SSH_AUTH_SOCK=/run/user/1000/ssh-agent.socket
eval $(keychain --eval --quiet id_ed25519 --inherit any-once)
