# Repository guidance

## Purpose and layout

- This repository contains personal dotfiles deployed with GNU Stow.
- `common/` contains configuration shared across operating systems.
- `freebsd/`, `linux/`, `macos/`, and `windows/` are platform packages.
- Symlinks from platform packages into `common/` are intentional. Preserve the
  shared source unless a configuration genuinely differs by platform.

## Platform conventions

- Shared Hyprland configuration lives in `common/hypr/` and uses Lua.
- Treat FreeBSD as authoritative when shared FreeBSD and Linux Hyprland behavior
  differs. Keep platform-specific commands, paths, and integrations isolated in
  their platform packages.
- FreeBSD Hyprland behavior has been runtime-tested. Do not describe the Linux
  desktop configuration as runtime-verified until it has been tested in a
  Hyprland environment.
- Neovim configuration is shared. Prefer one shared Neovim screenshot instead
  of duplicating the same workflow in every platform gallery.

## Documentation

- Keep `README.md` user-facing: installation, dependencies, usage, and visual
  previews belong there.
- Put agent-facing architecture and validation guidance in this file. Track
  temporary work and future tasks in the issue tracker rather than the README.
- Use `macOS` consistently.
- Keep platform screenshot galleries collapsed by default.
- Before publishing screenshots, inspect visible content and metadata for
  hostnames, IP addresses, usernames, private paths, notifications, credentials,
  and sensitive process details.

## Validation

- Run `git diff --check` after edits.
- Use the README's simulated Stow command for each affected platform package
  before applying it.
- Format shared Hyprland Lua with StyLua and verify it parses before handing off
  changes.
- Distinguish structural or syntax validation from runtime validation in the
  handoff summary.
