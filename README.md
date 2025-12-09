# m8a Default Dotfiles

This repository contains the default dotfile configuration for m8a workspaces.

## Default Configuration
The default setup includes:
- **Shell**: Zsh
- **Framework**: Oh My Zsh
- **Prompt**: Starship

## Configuration (`m8a.yaml`)
This repository contains an `m8a.yaml` file which tells the `m8a` CLI how to install the dotfiles.

```yaml
version: "v1"
type: "dotfiles"
# Points to the script that 'm8a source' will execute
install: "./install.sh"
```

## Usage
To install or update your dotfiles, simply run:

```bash
m8a source
```

This command looks at the `install` property in `m8a.yaml` and executes the specified script.

## Examples
The `/examples` directory contains alternative configurations for different workflows:
- **Minimal Bash**: Lightweight, standard Bash setup.
- **Fish Shell**: Modern shell with autosuggestions.
- **Powerlevel10k**: Advanced Zsh setup.
- **DevOps Toolbox**: Pre-configured aliases for K8s, Docker, etc.
- **Nix Home Manager**: Declarative configuration.

**NOTE:** The versions in the examples are not guaranteed to be up-to-date. Please check the repository for the latest versions.
We also don't guarantee that the examples will work in all cases. Some examples may require additional dependencies or configuration. We roughly tested the examples, but they are just examples in the end. YMMV.

### Switching Examples
To use one of the examples, edit `m8a.yaml` and change the `install` path to point to the desired example's install script.

**Example: Switch to Fish**
Open `m8a.yaml`:
```yaml
install: "./examples/fish-shell/install.sh"
```

Then run:
```bash
m8a source
```
