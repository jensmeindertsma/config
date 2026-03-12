set quiet

help:
    just --list

link system:   
    stow --dir systems --target ~ {{system}}
    @echo "✅ Linked 'systems/{{system}}/home'"
