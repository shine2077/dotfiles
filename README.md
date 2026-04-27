# dotfiles

Personal dotfiles managed with `GNU Stow`.

This repository keeps application configs in per-package directories and deploys
them into `$HOME` with symlinks created by `stow`.

## Repository Layout

- `zsh/`: Zsh config, including `zimfw` settings
- `kitty/`: Kitty terminal config and theme files
- `nvim/`: Neovim config based on LazyVim
- `tmux/`: local `oh-my-tmux` overrides
- `yazi/`: Yazi config and plugins

## Requirements

Install the tools you actually plan to use. The minimum requirement is:

- `git`
- `stow`

Common optional dependencies:

- `zsh`
- `kitty`
- `nvim`
- `tmux`
- `yazi`

Additional notes:

- `tmux/.tmux.conf.local` is meant to be used with `oh-my-tmux`
- `yazi/.config/yazi/plugins/starship.yazi` is tracked as a Git submodule

## Bootstrap on a New Machine

Clone the repository:

```sh
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
```

Initialize submodules:

```sh
git submodule update --init --recursive
```

If you use `tmux`, install `oh-my-tmux` first:

```sh
git clone --depth=1 https://github.com/gpakosz/.tmux.git ~/.tmux
ln -sf ~/.tmux/.tmux.conf ~/.tmux.conf
```

## Deploy with Stow

From the repository root, stow only what you want on the current machine:

```sh
stow zsh
stow kitty
stow nvim
stow tmux
stow yazi
```

You can also deploy multiple packages at once:

```sh
stow zsh kitty nvim tmux yazi
```

## Update Workflow

Pull the latest changes:

```sh
git pull --rebase
git submodule update --init --recursive
```

Restow a package after changes if needed:

```sh
stow zsh
```

To remove a package's symlinks:

```sh
stow -D zsh
```

## Notes

- This repository tracks reusable configuration, not local runtime state
- Local files such as `nvim/.config/nvim/lazy-lock.json`,
  `yazi/.config/yazi/gvfs.private`, and `.codex` are intentionally ignored
- Some configs assume the related application is already installed
- Some settings may still be machine-specific and may need local adjustment
