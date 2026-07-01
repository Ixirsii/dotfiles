# Dotfiles

## Stow Packages

Apply the shared config plus the package for the current OS.

### macOS

Preview changes:

```sh
stow --simulate --verbose --restow --target="$HOME" common macos
```

Apply changes:

```sh
stow --verbose --restow --target="$HOME" common macos
```

### Linux

Preview changes:

```sh
stow --simulate --verbose --restow --target="$HOME" common linux
```

Apply changes:

```sh
stow --verbose --restow --target="$HOME" common linux
```

### Windows

Preview changes:

```sh
stow --simulate --verbose --restow --target="$HOME" common windows
```

Apply changes:

```sh
stow --verbose --restow --target="$HOME" common windows
```
