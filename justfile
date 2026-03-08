set quiet

help:
    just --list

link system:   
    stow --dir systems/{{system}} --target ~ home
    sudo stow --dir systems/{{system}} --target / system
    @echo "✅ Linked 'systems/{{system}}'"
