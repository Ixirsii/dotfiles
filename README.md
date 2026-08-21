# Dotfiles

[![Discord](https://img.shields.io/discord/452233740408717313?color=738ADB&label=discord&logo=discord)][1]
[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)][2]

## Submodules

This repository has submodules for tmux and zsh plugins.
Initialize them with `git submodule update --init --recursive`.

## Stow packages

Apply the shared config plus the package for the current OS.

### FreeBSD

Preview changes:

```sh
stow --simulate --verbose --restow --target="$HOME" freebsd
```

Apply changes:

```sh
stow --verbose --restow --target="$HOME" freebsd
```

### Linux

Preview changes:

```sh
stow --simulate --verbose --restow --target="$HOME" linux
```

Apply changes:

```sh
stow --verbose --restow --target="$HOME" linux
```

### MacOS

Preview changes:

```sh
stow --simulate --verbose --restow --target="$HOME" macos
```

Apply changes:

```sh
stow --verbose --restow --target="$HOME" macos
```

Capture macOS Spaces, display, Dock, WindowServer, and Yabai state:

```sh
spaces-debug
```

Capture the broken state, restart Dock and Yabai, then compare the resulting
state without deleting Spaces:

```sh
spaces-recover
```

### Windows

Manually create links from `windows` module into your home directory

## Dependencies

Required dependencies must be installed for the corresponding configuration to
work. Optional dependencies provide configured tools and features but are only
needed when those tools are used.

### Common

#### Required

- [atuin][3]
- [fnm][4]
- [Git][5]
- [GnuPG][6]
- [GNU Stow][7]
- [starship][8]
- [zoxide][9]
- [zsh][10]

#### Optional

- [bat][11]
- [btop++][12]
- [bun (deprecated)][13]
- [delta][14]
- [eza][15]
- [fastfetch][16]
- [fd][17]
- [fzf][18]
- [lazygit][19]
- [neovim][20]
- [Nerd fonts][21]
- [Node.js][22]
- [OpenCode][23]
- [pnpm][24]
- [ripgrep][25]
- [rustup (and cargo)][26]
- [SDKMAN][27]
- [tmux][28]
- [wezterm][29]
- [yazi][30]
- [Zen browser][31]

### FreeBSD

#### Required

- [Hyprland][32]
- [Transmission][33]
- [waybar][34]

#### Optional

- [Google Fonts][35]
- [mako][36]
- [nwg-bar][37]

### Linux

#### Required

- [Hyprland][38]
- [Transmission][39]
- [waybar][40]

#### Optional

- [mako][41]
- [MPD][42]
- [ncmpcpp][43]
- [nwg-bar][44]

### macOS

#### Required

- [Homebrew][45]
- [SketchyBar][46]
- [skhd][47]
- [Yabai][48]

### Windows

#### Required

- [Komorebi][49]
- [PowerShell][50]
- [whkd][51]

[1]: https://discord.gg/KTgshSbEUU
[2]: https://opensource.org/license/bsd-3-clause
[3]: https://atuin.sh
[4]: https://github.com/Schniz/fnm
[5]: https://git-scm.com
[6]: https://gnupg.org
[7]: https://www.gnu.org/software/stow/
[8]: https://starship.rs
[9]: https://github.com/ajeetdsouza/zoxide
[10]: https://www.zsh.org
[11]: https://github.com/sharkdp/bat
[12]: https://github.com/aristocratos/btop
[13]: https://bun.com
[14]: https://github.com/dandavison/delta
[15]: https://github.com/eza-community/eza
[16]: https://github.com/fastfetch-cli/fastfetch
[17]: https://github.com/sharkdp/fd
[18]: https://github.com/junegunn/fzf
[19]: https://lazygit.dev
[20]: https://neovim.io
[21]: https://www.nerdfonts.com
[22]: https://nodejs.org
[23]: https://opencode.ai
[24]: https://pnpm.io
[25]: https://github.com/BurntSushi/ripgrep
[26]: https://rustup.rs
[27]: https://sdkman.io
[28]: https://github.com/tmux/tmux
[29]: https://wezterm.org/index.html
[30]: https://yazi-rs.github.io
[31]: https://zen-browser.app
[32]: https://hypr.land
[33]: https://transmissionbt.com
[34]: https://github.com/alexays/waybar
[35]: https://cgit.freebsd.org/ports/tree/x11-fonts/google-fonts
[36]: https://github.com/emersion/mako
[37]: https://github.com/nwg-piotr/nwg-bar
[38]: https://hypr.land
[39]: https://transmissionbt.com
[40]: https://github.com/alexays/waybar
[41]: https://github.com/emersion/mako
[42]: https://www.musicpd.org
[43]: https://github.com/ncmpcpp/ncmpcpp
[44]: https://github.com/nwg-piotr/nwg-bar
[45]: https://brew.sh
[46]: https://github.com/FelixKratz/SketchyBar
[47]: https://github.com/koekeishiya/skhd
[48]: https://github.com/koekeishiya/yabai
[49]: https://github.com/LGUG2Z/komorebi
[50]: https://learn.microsoft.com/en-us/powershell/scripting/install/install-powershell-on-windows?view=powershell-7.6
[51]: https://github.com/LGUG2Z/whkd
