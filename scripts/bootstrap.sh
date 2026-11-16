#!/usr/bin/env bash
set -euo pipefail

# PlainNix bootstrap script
# This script prepares a Debian-based system with a minimal shell-first toolchain.

export DEBIAN_FRONTEND=noninteractive

if [[ $(id -u) -ne 0 ]]; then
  echo "Please run this script as root."
  exit 1
fi

if ! command -v apt-get >/dev/null 2>&1; then
  echo "This script expects a Debian or Debian-based system with apt-get installed."
  exit 1
fi

# Update package lists
apt-get update
apt-get upgrade -y

# Install a small, practical base system
apt-get install -y --no-install-recommends \
  bash \
  ca-certificates \
  curl \
  git \
  sudo \
  vim \
  nano \
  less \
  tree \
  htop \
  net-tools \
  iproute2 \
  openssh-client \
  openssh-server \
  gnupg \
  rsync \
  tzdata \
  software-properties-common \
  python3 \
  python3-pip \
  build-essential

# Create a standard PlainNix user if it does not exist
if ! id -u plainnix >/dev/null 2>&1; then
  useradd --create-home --shell /bin/bash plainnix
  usermod -aG sudo plainnix
  echo 'plainnix:plainnix' | chpasswd
fi

# Ensure SSH is allowed to start if enabled later
systemctl enable ssh 2>/dev/null || true

# Create common directories
mkdir -p /opt/plainnix /srv/plainnix /home/plainnix/.local/bin
chown -R plainnix:plainnix /home/plainnix

# Install a simple default shell configuration
cat > /home/plainnix/.bashrc <<'EOF'
# PlainNix shell defaults
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
export EDITOR=nano
export VISUAL=nano
EOF

chown plainnix:plainnix /home/plainnix/.bashrc

# Configure a simple welcome marker
cat > /etc/motd <<'EOF'
Welcome to PlainNix.
A lightweight Debian-based Linux system for simple, reliable workflows.
EOF

echo "PlainNix base installation completed."
echo "Reboot and then run: sudo -u plainnix ./scripts/first-boot.sh"
