#!/usr/bin/env bash
set -euo pipefail

# Optional Microsoft Edge and Microsoft 365 web-app integration for PlainNix.
# Run as root with sudo; this adds Microsoft's official Edge APT repository.

if [[ $(id -u) -ne 0 ]]; then
  echo "Run this script with sudo: sudo ./scripts/install-microsoft-apps.sh" >&2
  exit 1
fi

if ! command -v apt-get >/dev/null 2>&1 || ! command -v dpkg-query >/dev/null 2>&1; then
  echo "This script requires a Debian-based system with apt-get and dpkg." >&2
  exit 1
fi

architecture=$(dpkg --print-architecture)
if [[ "$architecture" != amd64 ]]; then
  echo "Microsoft Edge's Linux package is only configured here for amd64; detected: $architecture" >&2
  exit 1
fi

# Associate desktop shortcuts with the account that invoked sudo, or PlainNix's
# default account when called directly as root.
desktop_user=${SUDO_USER:-plainnix}
if [[ "$desktop_user" == root ]] || ! getent passwd "$desktop_user" >/dev/null; then
  echo "Could not identify a regular desktop user. Run this with sudo from that user's session." >&2
  exit 1
fi
user_home=$(getent passwd "$desktop_user" | cut -d: -f6)
if [[ -z "$user_home" || ! -d "$user_home" ]]; then
  echo "Could not find the home directory for $desktop_user." >&2
  exit 1
fi

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y --no-install-recommends ca-certificates curl gnupg

install -d -m 0755 /etc/apt/keyrings
key_tmp=$(mktemp)
trap 'rm -f "$key_tmp"' EXIT
curl --fail --location --silent --show-error https://packages.microsoft.com/keys/microsoft.asc -o "$key_tmp"
gpg --dearmor --yes --output /etc/apt/keyrings/microsoft-edge.gpg "$key_tmp"
chmod 0644 /etc/apt/keyrings/microsoft-edge.gpg

cat > /etc/apt/sources.list.d/microsoft-edge.list <<'EOF'
deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft-edge.gpg] https://packages.microsoft.com/repos/edge stable main
EOF

apt-get update
apt-get install -y microsoft-edge-stable

applications_dir="$user_home/.local/share/applications"
dock_launchers="$user_home/.config/plank/dock1/launchers"
install -d -o "$desktop_user" -g "$desktop_user" "$applications_dir" "$dock_launchers"

write_web_app() {
  local id="$1" title="$2" url="$3" icon="$4"
  local desktop_file="$applications_dir/plainnix-${id}.desktop"
  cat > "$desktop_file" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=$title
Comment=Open $title in Microsoft Edge
Exec=/usr/bin/microsoft-edge-stable --app=$url
Icon=$icon
Terminal=false
Categories=Office;Network;
StartupNotify=true
EOF
  chown "$desktop_user:$desktop_user" "$desktop_file"
  chmod 0644 "$desktop_file"

  cat > "$dock_launchers/plainnix-${id}.dockitem" <<EOF
[PlankDockItemPreferences]
Launcher=file://$desktop_file
EOF
  chown "$desktop_user:$desktop_user" "$dock_launchers/plainnix-${id}.dockitem"
}

write_web_app edge "Microsoft Edge" "https://www.microsoft.com/edge" "microsoft-edge"
write_web_app microsoft365 "Microsoft 365" "https://www.microsoft365.com/" "applications-office"
write_web_app word "Word" "https://www.microsoft365.com/launch/word" "applications-office"
write_web_app excel "Excel" "https://www.microsoft365.com/launch/excel" "applications-office"
write_web_app powerpoint "PowerPoint" "https://www.microsoft365.com/launch/powerpoint" "applications-office"
write_web_app teams "Microsoft Teams" "https://teams.microsoft.com/" "video-conference"
write_web_app onedrive "OneDrive" "https://onedrive.live.com/" "folder-remote"

printf 'Microsoft Edge and Microsoft 365 web shortcuts are installed for %s.\n' "$desktop_user"
printf 'Open them from the Applications menu or the Plank dock, then sign in.\n'
printf 'If dock icons do not appear, sign out and back in or restart Plank.\n'
