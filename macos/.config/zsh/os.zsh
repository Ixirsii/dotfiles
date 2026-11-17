export PNPM_HOME="/Users/ryan/Library/pnpm"

if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv zsh)"
fi

# Homebrew .NET tools need the runtime location as well as dotnet on PATH.
if (($+commands[brew])); then
  dotnet_prefix="$(brew --prefix dotnet@10)"
  if [[ -d "$dotnet_prefix/libexec" ]]; then
    export PATH="$dotnet_prefix/bin:$PATH"
    export DOTNET_ROOT="${DOTNET_ROOT:-$dotnet_prefix/libexec}"
  fi
  unset dotnet_prefix
fi
