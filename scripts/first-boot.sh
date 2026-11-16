#!/usr/bin/env bash
set -euo pipefail

# PlainNix first-boot configuration
# Intended to run after the base system is installed.

if [[ $(id -u) -ne 0 ]]; then
  echo "Please run this script as root."
  exit 1
fi

# Install optional packages for a shell-first system
apt-get update
apt-get install -y --no-install-recommends \
  wget \
  unzip \
  xz-utils \
  file \
  zip \
  man-db \
  procps

# Create standard directories for user work
mkdir -p /home/plainnix/projects /home/plainnix/Documents /home/plainnix/Downloads
chown -R plainnix:plainnix /home/plainnix

# Add helpful shell aliases for beginners
cat >> /home/plainnix/.bashrc <<'EOF'

# PlainNix beginner-friendly aliases
alias update='sudo apt-get update && sudo apt-get upgrade -y'
alias install='sudo apt-get install -y'
export PATH="$PATH:/home/plainnix/.local/bin"
EOF

chown plainnix:plainnix /home/plainnix/.bashrc

# Optional: ensure a clean system state
systemctl daemon-reload 2>/dev/null || true

printf '\nPlainNix setup is ready. Log in as plainnix and start exploring.\n'
