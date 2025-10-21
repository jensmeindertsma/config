help:
    just --list

link system:
    @echo "Linking 'systems/{{system}}' to the home directory:"
    stow --target ~ --dir systems {{system}}
