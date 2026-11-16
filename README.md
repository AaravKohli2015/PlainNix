# PlainNix

PlainNix is a lightweight, Debian-based Linux system with a friendly graphical desktop, a familiar web browser, and simple shell workflows. It aims to feel approachable for people used to Android or macOS, while remaining a real, customizable Debian system.

## What you get

- **XFCE desktop** with a clean panel, application menu, and desktop settings
- **Plank app dock** at the bottom with quick-launch icons for Firefox, Files, and Terminal
- **Firefox ESR** as the default browser
- Optional **Microsoft Edge** and desktop-style shortcuts for Microsoft 365 web apps
- Network, audio, Bluetooth, printing, and display tools for everyday desktop use
- A non-root `plainnix` account; the setup asks you to choose its password
- Helpful shell defaults and common command-line utilities
- Debian's standard APT package management

PlainNix takes inspiration from the discoverability of Android and the polished desktop feel of macOS without copying their proprietary interface or software. The dock provides a simple app bar; XFCE remains customizable through its settings and panel preferences.

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
6. The app dock starts automatically. Open Firefox, Files, or Terminal from it. On first login, run the optional user setup:

   ```bash
   ./scripts/first-boot.sh
   ```

The bootstrap may replace the display manager with LightDM. If a `plainnix` account already exists, it will not change its password.

## Microsoft Edge and Microsoft 365

Microsoft Edge is an optional native Linux browser. To install it and add Microsoft 365 web app shortcuts to the Applications menu and Plank dock, run this from a terminal in the repository:

```bash
sudo ./scripts/install-microsoft-apps.sh
```

Sign out and back in (or restart Plank) if the new dock shortcuts do not appear immediately. Open Edge, Word, Excel, PowerPoint, Teams, or OneDrive from the app dock or Applications menu, then sign in with your Microsoft account. These Office, Teams, and OneDrive entries are web apps launched in Edge's app window—not native Linux desktop editions. They require internet access and an account; available features depend on your Microsoft account and subscription. See [docs/microsoft-apps.md](docs/microsoft-apps.md) for details and manual alternatives.

## Customize the desktop

- Use **Applications → Settings** to adjust display, appearance, keyboard, and power settings.
- Right-click the XFCE panel to add launchers or change its layout.
- Right-click the Plank dock or open **Plank Preferences** to customize its size, position, and behavior.
- Pin other apps by adding their `.desktop` launchers to `~/.config/plank/dock1/launchers/`.
- Install software with the graphical package manager or `sudo apt install <package>`.

## Project layout

- `scripts/bootstrap.sh` — installs the desktop, browser, dock, utilities, and account setup on Debian
- `scripts/first-boot.sh` — creates useful folders and adds optional shell aliases for the current user
- `scripts/install-microsoft-apps.sh` — optional Microsoft Edge and Microsoft 365 web-app integration
- `config/packages.txt` — package manifest for the PlainNix desktop
- `docs/architecture.md` — design notes and current limitations
- `docs/microsoft-apps.md` — Microsoft browser and web-app instructions

## Roadmap

- Build a reproducible Debian live image / installable ISO
- Add a first-login welcome screen with setup shortcuts
- Refine desktop defaults, accessibility, and touch-friendly settings
- Offer optional desktop profiles for lower-powered machines

## Safety note

Use this project on a fresh test installation or virtual machine until you have reviewed the scripts. The bootstrap requires root privileges to install system packages and configure login and network services. The optional Microsoft integration adds Microsoft's official Edge APT signing key and package repository so Edge can be installed and updated with APT. Neither script configures a default password or enables automatic login.
