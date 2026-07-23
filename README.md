# Dotfiles

## Submodules

This repository has submodules for tmux and zsh plugins.
Initialize them with `git submodule update --init --recursive`.

## Dependencies

The following programs are expected to be available on the target system:

### Common

- [atuin][2]
- [bat][3]
- [btop++][5]
- [bun (deprecated)][6]
- [delta][7]
- [dust][8]
- [eza][9]
- [fastfetch][10]
- [fd][11]
- [fnm][12]
- [fzf][13]
- [lazygit][16]
- [neovim][18]
- [Nerd fonts][19]
- [ripgrep][22]
- [rustup (and cargo)][23]
- [SDKMAN][24]
- [starship][27]
- [wezterm][31]
- [yazi][32]
- [Zen browser][33]
- [zoxide][34]
- [zsh][35]

### FreeBSD

- [Google Fonts][12]
- [Hyprland][15]
- [mako][17]
- [nwg-bar][20]
- [Transmission][29]
- [waybar][30]

### Linux

- [Hyprland][15]
- [mako][17]
- [nwg-bar][20]
- [tmux][28]
- [Transmission][29]
- [waybar][30]

### macOS

- [AeroSpace][1]
- [Homebrew][4]
- [SketchyBar][25]
- [SketchyBar app font][26]

### Windows

- [PowerShell][21]

## Stow Packages

Apply the shared config plus the package for the current OS.

### FreeBSD

Preview changes:

```sh
stow --simulate --verbose --restow --target="$HOME" common freebsd
```

Apply changes:

```sh
stow --verbose --restow --target="$HOME" common freebsd
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

### macOS

Preview changes:

```sh
stow --simulate --verbose --restow --target="$HOME" common macos
```

Apply changes:

```sh
stow --verbose --restow --target="$HOME" common macos
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

[1]: https://github.com/nikitabobko/AeroSpace
[2]: https://atuin.sh
[3]: https://github.com/sharkdp/bat
[4]: https://brew.sh
[5]: https://github.com/aristocratos/btop
[6]: https://bun.com
[7]: https://github.com/dandavison/delta
[8]: https://github.com/bootandy/dust
[9]: https://github.com/eza-community/eza
[10]: https://github.com/fastfetch-cli/fastfetch
[11]: https://github.com/sharkdp/fd
[12]: https://github.com/Schniz/fnm
[13]: https://github.com/junegunn/fzf
[14]: https://cgit.freebsd.org/ports/tree/x11-fonts/google-fonts
[15]: https://hypr.land
[16]: https://lazygit.dev
[17]: https://github.com/emersion/mako
[18]: https://neovim.io
[19]: https://www.nerdfonts.com
[20]: https://github.com/nwg-piotr/nwg-bar
[21]: https://learn.microsoft.com/en-us/powershell/scripting/install/install-powershell-on-windows?view=powershell-7.6
[22]: https://github.com/BurntSushi/ripgrep
[23]: https://rustup.rs
[24]: https://sdkman.io
[25]: https://github.com/felixkratz/sketchybar
[26]: https://github.com/kvndrsslr/sketchybar-app-font
[27]: https://starship.rs
[28]: https://github.com/tmux/tmux
[29]: https://transmissionbt.com
[30]: https://github.com/alexays/waybar
[31]: https://wezterm.org/index.html
[32]: https://yazi-rs.github.io
[33]: https://zen-browser.app
[34]: https://github.com/ajeetdsouza/zoxide
[35]: https://www.zsh.org
