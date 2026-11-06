# Dotfiles

[![Discord](https://img.shields.io/discord/452233740408717313?color=b4befe&label=discord&labelColor=1e1e2e&logo=discord&style=flat)][1]
[![License](https://img.shields.io/badge/License-BSD_3--Clause-89b4fa?labelColor=1e1e2e&style=flat)][2]
[![Checks](https://codeberg.org/Ixirsii/dotfiles/badges/workflows/checks.yml/badge.svg?branch=main&event=push&label=checks&labelColor=1e1e2e&style=flat)][3]

Personal configuration shared across FreeBSD, Linux, macOS, and Windows.

## Preview

![Desktop preview](screenshots/freebsd/desktop.png)

Additional screenshots are grouped with each operating system below.

## Getting started

Initialize the tmux and zsh plugin submodules after cloning the repository:

```sh
git submodule update --init --recursive
```

### Common dependencies

Required dependencies must be installed for the shared configuration to work.
Optional dependencies provide configured tools and features but are only needed
when those tools are used.

<details>
<summary>Required dependencies</summary>

- [atuin][3]
- [fnm][4]
- [Git][5]
- [GnuPG][6]
- [GNU Stow][7]
- [starship][8]
- [zoxide][9]
- [zsh][10]

</details>

<details>
<summary>Optional dependencies</summary>

- [bat][11]
- [btop++][12]
- [bun (deprecated)][13]
- [delta][14]
- [eza][15]
- [fastfetch][16]
- [fd][17]
- [fzf][18]
- [Go][53]
- [lazygit][19]
- [neovim][20]
- [Nerd fonts][21]
- [Node.js][22]
- [Odin][54]
- [OpenCode][23]
- [pnpm][24]
- [ripgrep][25]
- [rustup (and cargo)][26]
- [SDKMAN][27]
- [tmux][28]
- [wezterm][29]
- [yazi][30]
- [Zen browser][31]

</details>

## FreeBSD

Preview the changes:

```sh
stow --simulate --verbose --restow --target="$HOME" freebsd
```

Apply the configuration:

```sh
stow --verbose --restow --target="$HOME" freebsd
```

<details>
<summary>Screenshots</summary>

Screenshots will be added under `screenshots/freebsd/`.
![FreeBSD desktop preview](screenshots/freebsd/desktop.png)
![Waybar preview](screenshots/freebsd/waybar.png)

</details>

<details>
<summary>Dependencies (2 required, 3 optional)</summary>

### Required

- [Hyprland][32]
- [waybar][34]

### Optional

- [Google Fonts][35]
- [mako][36]
- [nwg-bar][37]

</details>

## Linux

Preview the changes:

```sh
stow --simulate --verbose --restow --target="$HOME" linux
```

Apply the configuration:

```sh
stow --verbose --restow --target="$HOME" linux
```

<details>
<summary>Screenshots</summary>

Screenshots will be added under `screenshots/linux/`.

</details>

<details>
<summary>Dependencies (2 required, 2 optional)</summary>

### Required

- [Hyprland][38]
- [waybar][40]

### Optional

- [mako][41]
- [nwg-bar][44]

</details>

## macOS

Preview the changes:

```sh
stow --simulate --verbose --restow --target="$HOME" macos
```

Apply the configuration:

```sh
stow --verbose --restow --target="$HOME" macos
```

<details>
<summary>Screenshots</summary>

![macOS desktop preview](screenshots/macos/desktop.png)
![SketchyBar preview](screenshots/macos/sketchybar.png)

</details>

<details>
<summary>Dependencies (4 required)</summary>

- [Homebrew][45]
- [SketchyBar][46]
- [skhd][47]
- [Yabai][48]

</details>

## Windows

Manually create links from the `windows` package into your home directory.

<details>
<summary>Screenshots</summary>

Screenshots will be added under `screenshots/windows/`.

</details>

<details>
<summary>Dependencies (1 required)</summary>

- [PowerShell][50]

</details>

## Neovim development tools

Neovim 0.12 or newer is required for the shared plugin configuration.

Launching `vim` without file arguments opens the Snacks explorer in the current
directory, alongside the dashboard. Piped input and restored sessions keep their
normal startup behavior.

Completion uses Blink v1 with LSP, LuaSnip/friendly-snippets, buffer words, and
file paths. `Ctrl-j` / `Ctrl-k` selects the next / previous suggestion,
`Ctrl-Space` opens completion or its documentation, `Enter` accepts the selected
suggestion (or the first if none is selected), and `Ctrl-e` cancels completion.
`Ctrl-b` / `Ctrl-f` scrolls documentation; `Tab` / `Shift-Tab` moves between
snippet placeholders. Blink inserts function-call brackets on completion;
nvim-autopairs handles brackets typed manually. The native fuzzy matcher is
downloaded automatically when supported, with a Lua fallback otherwise.

Editing and Git keybindings (`<leader>` is Space):

- `[c` / `]c`: previous / next Git hunk.
- `<leader>hs` / `<leader>hr`: stage (or unstage) / reset a hunk; also works on
  selected lines in Visual mode. Reset discards those working-tree changes.
- `<leader>hp` / `<leader>hb` / `<leader>hd`: preview hunk / blame line / diff
  against the index.
- `<leader>sr`: open project search and replacement with grug-far. In Visual
  mode, prefill the search with the selection. Use `:GrugFarWithin` to restrict
  replacement to the selected range. Grug-far's buffer actions use the default
  local leader, `\`; its footer shows the available commands. Requires ripgrep
  14 or newer (15 or newer recommended).
- `saiw"`: surround a word with double quotes; `sd"`: delete surrounding double
  quotes; `sr"'`: replace double quotes with single quotes. In Visual mode,
  select text and press `sa` followed by the desired surrounding character.
- `cia` / `daa`: change an argument / delete an argument with its separator
  using mini.ai. `vif` / `vaf` selects inside / around a function call.
- `<leader>j`: Flash jump. Type some target text, then press its displayed label.
  `<leader>J`: label and select Tree-sitter nodes around the cursor. Both work
  in Normal, Visual, and operator-pending modes (for example, `d<leader>j`).
  Flash uses leader mappings so mini.surround's `s` mappings remain available;
  the usual `f` / `t` motions and `/` search retain their existing behavior.
- `<leader>um`: toggle rendered Markdown headings, tables, and code blocks.

Rust uses rustaceanvim to manage rust-analyzer. `<leader>rr` lists runnable
targets, `<leader>rm` expands a macro, and `<leader>rc` opens `Cargo.toml`.
Neotest provides Rust tests through rustaceanvim and Go tests through
neotest-golang; install Rust/Cargo or Go on each host as needed. JavaScript test
runners require a project-appropriate Neotest adapter before they can be used.

- `<leader>tt` / `<leader>tT`: run the nearest test / current file's tests.
- `<leader>tl` / `<leader>tr`: rerun the last test / stop a test.
- `<leader>ts`: toggle the test summary.
- `<leader>te` / `<leader>tO`: open test output / toggle the output panel.

Tree-sitter highlighting starts for buffers with installed parsers. Tree-sitter
indentation is enabled where an indentation query is available; other filetypes
keep their normal indentation. Run `:TSUpdate` after updating Tree-sitter.

Diagnostic keybindings (`<leader>` is Space):

- `<leader>dd`: show diagnostics for the current line.
- `<leader>db` / `<leader>dp`: toggle a persistent Trouble bottom split for
  buffer / project diagnostics. Press Enter to jump to a diagnostic while
  keeping the list open; press `q` in the list to close it.
- `<leader>sd` / `<leader>sD`: search project / buffer diagnostics in Snacks.
- `[d` / `]d`: jump to the previous / next diagnostic.

Project diagnostics include all diagnostics reported to Neovim; language servers
may only report diagnostics for files that have been opened.

Install the host-level language servers and formatters from the repository's
checked-in manifests:

```sh
scripts/install-neovim-tools
scripts/check-neovim-tools
```

Preview the installation commands without changing the system:

```sh
scripts/install-neovim-tools --dry-run
```

<details>
<summary>Screenshots</summary>

![neovim preview](screenshots/common/neovim.png)

</details>
<details>
<summary>Tooling details</summary>

The installer uses FreeBSD `pkg`, a macOS Brewfile, or the Arch Linux package
manifest for native packages. Version-pinned npm, Go, and Cargo manifests cover
portable tools, while rustup supplies `rust-analyzer` and `rustfmt`. Other Linux
distributions must translate `packages/linux.txt` to their native package
names. OLS and `odinfmt` must be installed manually on FreeBSD because they are
not currently available from `pkg`.

All executables must be on the `PATH` inherited by Neovim. The configured
language servers are:

```text
bash-language-server
docker-language-server
gopls
hyprls
lua-language-server
ols
rust-analyzer
sqls
tailwindcss-language-server
taplo
typescript-language-server
vscode-css-language-server
vscode-eslint-language-server
vscode-html-language-server
vscode-json-language-server
yaml-language-server
```

The configured formatters are `gofmt`/`goimports`, `odinfmt`, project-local
`prettier`, `rustfmt`, `shfmt`, `stylua`, and `taplo`. Conform automatically
prefers `node_modules/.bin/prettier` when it exists. The ESLint language server
similarly discovers the project's ESLint installation and configuration, so
diagnostics remain available in Neovim without a global ESLint installation.

`sqls` supports PostgreSQL, MySQL, and SQLite. Database connections can be
defined outside this repository in `$XDG_CONFIG_HOME/sqls/config.yml`; see the
[upstream `sqls` connection configuration][52] for the supported DSN formats.

</details>

[1]: https://discord.gg/KTgshSbEUU
[2]: https://opensource.org/license/bsd-3-clause
[3]: https://codeberg.org/Ixirsii/dotfiles/actions/workflows/checks.yml
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
[34]: https://github.com/alexays/waybar
[35]: https://cgit.freebsd.org/ports/tree/x11-fonts/google-fonts
[36]: https://github.com/emersion/mako
[37]: https://github.com/nwg-piotr/nwg-bar
[38]: https://hypr.land
[40]: https://github.com/alexays/waybar
[41]: https://github.com/emersion/mako
[44]: https://github.com/nwg-piotr/nwg-bar
[45]: https://brew.sh
[46]: https://github.com/FelixKratz/SketchyBar
[47]: https://github.com/koekeishiya/skhd
[48]: https://github.com/koekeishiya/yabai
[50]: https://learn.microsoft.com/en-us/powershell/scripting/install/install-powershell-on-windows?view=powershell-7.6
[52]: https://github.com/sqls-server/sqls#db-configuration
[53]: https://go.dev
[54]: https://odin-lang.org
