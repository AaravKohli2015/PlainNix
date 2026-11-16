# PlainNix architecture

PlainNix is a Debian-based desktop project focused on approachable defaults, familiar tools, and a lightweight graphical experience.

## Current implementation

- Debian package management (`apt`) and Debian system services
- XFCE desktop environment, with a conventional panel, application menu, and settings tools
- Plank dock at the bottom with launchers for Firefox ESR, Thunar Files, and XFCE Terminal
- A small session startup helper moves the default XFCE panel to the top and launches Plank
- LightDM graphical login manager
- Firefox ESR web browser
- NetworkManager for desktop network connections
- Optional audio, Bluetooth, printing, archive, and file-manager support
- A regular `plainnix` user created by the bootstrap, with a password chosen interactively

## User experience goals

PlainNix takes inspiration from the discoverability of Android and the polished desktop feel of macOS: quick access to favorite apps, clear settings, and simple navigation. It does not copy proprietary interfaces. The Plank app dock provides a sleek, familiar app bar, while XFCE keeps the desktop lightweight and customizable.

The dock starts automatically in the XFCE session. Users can adjust its appearance and behavior through Plank Preferences and add launchers in `~/.config/plank/dock1/launchers/`.

## Setup flow

1. Start from an existing Debian installation with network access.
2. Run `sudo ./scripts/bootstrap.sh` to install the desktop, dock, and packages.
3. Reboot and sign in at LightDM as `plainnix`.
4. Optionally run `./scripts/first-boot.sh` to create personal folders and aliases.

The setup avoids a hard-coded password and does not enable automatic login. Existing `plainnix` account passwords are not changed.

## Limitations

The bootstrap configures an installed Debian system; this repository does not yet produce a live image or standalone installer. Package availability and the LightDM configuration flow depend on the Debian release. Run it in a disposable virtual machine before using it on a machine with important data. Review scripts before running privileged commands.

## Future directions

- Reproducible live image and installer build
- First-login welcome screen and graphical setup guide
- Refined accessibility, touch, theme, and panel defaults
- Optional lower-resource desktop profile
