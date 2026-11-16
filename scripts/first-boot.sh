#!/usr/bin/env bash
set -euo pipefail

# Optional per-user setup. Run as the user who will use the desktop; no root needed.

if [[ $(id -u) -eq 0 ]]; then
  echo "Run this as your regular desktop user, not as root." >&2
  exit 1
fi

mkdir -p "$HOME/.local/bin" \
  "$HOME/.config/autostart" \
  "$HOME/.config/plank/dock1/launchers" \
  "$HOME/Desktop" \
  "$HOME/Documents" \
  "$HOME/Downloads" \
  "$HOME/Music" \
  "$HOME/Pictures" \
  "$HOME/Videos" \
  "$HOME/projects"

cat > "$HOME/.config/autostart/plainnix-dock.desktop" <<'EOF'
[Desktop Entry]
Type=Application
Name=PlainNix App Dock
Comment=Quick access to your favorite applications
Exec=/usr/local/bin/plainnix-desktop-startup
OnlyShowIn=XFCE;
Terminal=false
EOF

for app in firefox-esr thunar xfce4-terminal; do
  launcher="$HOME/.config/plank/dock1/launchers/${app}.dockitem"
  if [[ ! -e "$launcher" ]]; then
    cat > "$launcher" <<EOF
[PlankDockItemPreferences]
Launcher=file:///usr/share/applications/${app}.desktop
EOF
  fi
done

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

printf '\nPlainNix is ready. The app dock provides quick access to Firefox, Files, and Terminal.\n'
printf 'Use Settings to personalize the panel, appearance, display, and power behavior.\n'
printf 'Right-click the dock or open Plank Preferences to adjust its look and behavior.\n'
