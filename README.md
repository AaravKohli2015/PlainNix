# PlainNix

PlainNix is a lightweight, Debian-based Linux system with a friendly graphical desktop, a familiar web browser, and simple shell workflows. It aims to feel approachable for people used to Android or macOS, while remaining a real, customizable Debian system.

## What you get

- **XFCE desktop** with a clean panel, application menu, and desktop settings
- **Firefox ESR** as the default web browser
- Network, audio, Bluetooth, printing, and display tools for everyday desktop use
- A non-root `plainnix` account; the setup asks you to choose its password
- Helpful shell defaults and common command-line utilities
- Debian's standard APT package management

PlainNix is inspired by the ease of use of Android and macOS, but it does not copy their interfaces or include their proprietary software. XFCE is intentionally lightweight and can be customized through **Settings** and **Panel** preferences.

## Try it on Debian

> The bootstrap script configures an existing Debian installation. It is not yet a standalone installer or bootable ISO. Test it in a virtual machine first; it installs a graphical desktop and changes system packages.

1. Install a supported Debian system with network access and a working `apt-get`.
2. Clone or copy this repository.
3. Run the bootstrap as root:

   ```bash
   sudo ./scripts/bootstrap.sh
   ```

4. Choose a password when prompted for the `plainnix` account.
5. Reboot and sign in to the XFCE desktop as `plainnix`.
6. Open Firefox from the applications menu. On first login, run the optional user setup:

   ```bash
   ./scripts/first-boot.sh
   ```

The bootstrap may replace the display manager with LightDM. If a `plainnix` account already exists, it will not change its password.

## Customize the desktop

- Use **Applications → Settings** to adjust display, appearance, keyboard, and power settings.
- Right-click the panel to add launchers or change its layout.
- Pin Firefox or other apps to the panel for quick access.
- Install software with the graphical package manager or `sudo apt install <package>`.

## Project layout

- `scripts/bootstrap.sh` — installs the desktop, browser, utilities, and account setup on Debian
- `scripts/first-boot.sh` — creates useful folders and adds optional shell aliases for the current user
- `config/packages.txt` — package manifest for the PlainNix desktop
- `docs/architecture.md` — design notes and current limitations

## Roadmap

- Build a reproducible Debian live image / installable ISO
- Add a first-login welcome screen with setup shortcuts
- Refine desktop defaults, accessibility, and touch-friendly settings
- Offer optional desktop profiles for lower-powered machines

## Safety note

Use this project on a fresh test installation or virtual machine until you have reviewed the scripts. The bootstrap requires root privileges to install system packages and configure login and network services. It does not configure a default password or enable automatic login.
