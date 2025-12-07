<div align="center">
    <h1>⚙️ config</h1>
    <i>My dotfiles.</i>
</div>
<br/>

## Introduction

This repository is where all my dotfiles and other configuration for all of my systems live. I use [`GNU Stow`](https://www.gnu.org/software/stow/) to symlink the files in here to the home directory. This allows me to manage the dotfiles in a comfortable place as opposed to the chaos that is your home directory (with cache and log files all over).

My dotfiles are organized by-system. I have several computers of which I manage the configuration files in this repository. Using the [`just` command runner](https://just.systems/) I can easily apply new changes for a specific system by running `just link {system}` where `{system}` is one of the subdirectories containing configuration files inside the `systems` folder.
