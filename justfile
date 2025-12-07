set quiet

help:
    just --list

link system:
    stow --target ~ --dir systems {{system}}
    @echo "✅ Linked 'systems/{{system}}' to the home directory"
