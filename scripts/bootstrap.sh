#!/usr/bin/env bash
set -euo pipefail

# PlainNix desktop bootstrap for an existing Debian installation.
# Run as root; review the README and test in a VM before using on a daily system.

export DEBIAN_FRONTEND=noninteractive

if [[ $(id -u) -ne 0 ]]; then
  echo "Please run this script as root (for example: sudo ./scripts/bootstrap.sh)." >&2
  exit 1
fi

if ! command -v apt-get >/dev/null 2>&1 || ! command -v dpkg-query >/dev/null 2>&1; then
  echo "PlainNix bootstrap expects a Debian-based system with apt-get and dpkg." >&2
  exit 1
fi

if ! grep -qiE 'debian|ubuntu' /etc/os-release; then
  echo "Warning: this system is not identified as Debian or Ubuntu; continuing may fail." >&2
fi

if ! id plainnix >/dev/null 2>&1; then
  echo "Choose a password for the PlainNix account. Input will not be shown."
  while true; do
    read -r -s -p "New password: " password
    echo
    read -r -s -p "Confirm password: " password_confirm
    echo
    if [[ -z "$password" ]]; then
      echo "Password cannot be empty. Try again."
    elif [[ "$password" != "$password_confirm" ]]; then
      echo "Passwords do not match. Try again."
    else
      break
    fi
  done
  useradd --create-home --shell /bin/bash plainnix
  printf 'plainnix:%s\n' "$password" | chpasswd
  unset password password_confirm
  usermod -aG sudo plainnix
else
  echo "The plainnix account already exists; leaving its password unchanged."
  if ! id -nG plainnix | grep -qw sudo; then
    usermod -aG sudo plainnix
  fi
fi

apt-get update
apt-get upgrade -y
apt-get install -y --no-install-recommends \
  xfce4 \
  xfce4-goodies \
  lightdm \
  network-manager \
  network-manager-gnome \
  firefox-esr \
  fonts-dejavu \
  fonts-noto \
  dbus-x11 \
  xorg \
  alsa-utils \
  pavucontrol \
  blueman \
  cups \
  gvfs \
  thunar-archive-plugin \
  file-roller \
  bash-completion \
  ca-certificates \
  curl \
  git \
  sudo \
  nano \
  less \
  tree \
  htop \
  iproute2 \
  openssh-client \
  gnupg \
  rsync \
  tzdata \
  python3 \
  python3-pip \
  build-essential

# Let the desktop manage networking and provide standard desktop services.
systemctl enable NetworkManager
systemctl enable lightdm
systemctl enable cups 2>/dev/null || true

install -d -o plainnix -g plainnix \
  /home/plainnix/.local/bin \
  /home/plainnix/Desktop \
  /home/plainnix/Documents \
  /home/plainnix/Downloads \
  /home/plainnix/Music \
  /home/plainnix/Pictures \
  /home/plainnix/Videos \
  /home/plainnix/projects

if [[ ! -e /home/plainnix/.bashrc ]]; then
  cat > /home/plainnix/.bashrc <<'EOF'
# PlainNix shell defaults
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
export EDITOR=nano
export VISUAL=nano
EOF
  chown plainnix:plainnix /home/plainnix/.bashrc
fi

cat > /etc/motd <<'EOF'
Welcome to PlainNix.
A lightweight Debian desktop with XFCE and Firefox ESR.
EOF

echo "PlainNix desktop setup is complete. Reboot, then sign in as plainnix."
echo "The login screen will start with LightDM."
