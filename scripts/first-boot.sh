#!/usr/bin/env bash
set -euo pipefail

# Optional per-user setup. Run as the user who will use the desktop; no root needed.

if [[ $(id -u) -eq 0 ]]; then
  echo "Run this as your regular desktop user, not as root." >&2
  exit 1
fi

mkdir -p "$HOME/.local/bin" \
  "$HOME/Desktop" \
  "$HOME/Documents" \
  "$HOME/Downloads" \
  "$HOME/Music" \
  "$HOME/Pictures" \
  "$HOME/Videos" \
  "$HOME/projects"

if ! grep -q 'PlainNix beginner-friendly aliases' "$HOME/.bashrc" 2>/dev/null; then
  cat >> "$HOME/.bashrc" <<'EOF'

# PlainNix beginner-friendly aliases
alias ll='ls -alF'
alias la='ls -A'
alias update='sudo apt-get update && sudo apt-get upgrade'
alias install='sudo apt-get install'
export EDITOR=nano
export VISUAL=nano
export PATH="$HOME/.local/bin:$PATH"
EOF
fi

printf '\nPlainNix is ready. Open the Applications menu to find Firefox and desktop settings.\n'
printf 'Use Settings to personalize the panel, appearance, display, and power behavior.\n'
