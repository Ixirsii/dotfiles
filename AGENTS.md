# AGENTS.md

## Repo Shape
- This is a GNU Stow dotfiles repo. Stow packages are top-level directories: `common/` plus one OS package such as `macos/`, `linux/`, `windows/`, or `freebsd/`.
- Use `common/` for shared config and OS directories only for platform-specific overrides.
- Root tooling files such as `.luarc.json`, `.stylua.toml`, `README*`, `.git*`, and `.DS_Store` are excluded from stow by `.stow-local-ignore`.

## Commands
- Preview macOS stow changes: `stow --simulate --verbose --restow --target="$HOME" common macos`
- Apply macOS stow changes: `stow --verbose --restow --target="$HOME" common macos`
- Preview Linux stow changes: `stow --simulate --verbose --restow --target="$HOME" common linux`
- Apply Linux stow changes: `stow --verbose --restow --target="$HOME" common linux`
- Preview Windows stow changes: `stow --simulate --verbose --restow --target="$HOME" common windows`
- Apply Windows stow changes: `stow --verbose --restow --target="$HOME" common windows`
- For Lua formatting, follow `.stylua.toml`; a focused check is `stylua --check .`.

## Gotchas
- Zsh plugin directories under `common/.config/zsh/` are Git submodules. If they are missing, run `git submodule update --init --recursive` before testing shell startup.
- `common/.zshrc` sources `~/.config/zsh/os.zsh`; edit the OS-specific file in the relevant package, not `common/.zshrc`, for platform-only setup.
- Neovim loads `common/.config/nvim/init.lua`, then `lua/config/lazy.lua`, then plugin specs from `lua/plugins/`. Filetype overrides live in `after/ftplugin/`.
- Linux Hyprland config is Lua-based and starts at `linux/.config/hypr/hyprland.lua`; FreeBSD Hyprland config is a separate monolithic `freebsd/.config/hypr/hyprland.conf`.
- Only `common/.config/opencode/opencode.jsonc` is tracked for OpenCode config. The adjacent `package.json`, lockfile, and `node_modules/` are ignored local dependency state.
- `common/.config/nvim/lazy-lock.json` is present, but root `.gitignore` ignores `lazy-lock.json`; do not assume plugin lockfile edits will be tracked.
