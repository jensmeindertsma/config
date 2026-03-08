set quiet

help:
    just --list

link system:   
    stow --dir systems/{{system}} --target ~ home
    @echo "✅ Linked 'systems/{{system}}/home'"
