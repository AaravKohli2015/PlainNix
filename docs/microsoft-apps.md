# Use Microsoft apps on PlainNix

PlainNix includes Firefox ESR. Microsoft Edge can be installed as an optional native Linux browser, while Word, Excel, PowerPoint, Teams, and OneDrive are accessed as web apps.

## Install Edge and add app shortcuts

From the PlainNix repository, run:

```bash
sudo ./scripts/install-microsoft-apps.sh
```

The script is for Debian-based **amd64** systems. It adds Microsoft's signed Edge package repository, installs `microsoft-edge-stable`, and creates shortcuts for Edge, Microsoft 365, Word, Excel, PowerPoint, Teams, and OneDrive for the regular user who ran `sudo`. The shortcuts appear in the Applications menu and are added to the Plank dock. It does not configure or save your Microsoft password.

If the dock is already running and doesn't show the new shortcuts, sign out and back in, or restart Plank from a terminal:

```bash
plank --replace >/dev/null 2>&1 &
```

Click an app icon and sign in using the Microsoft account you normally use. Microsoft 365 web apps need an internet connection. Features depend on your account and subscription. These are Edge app windows that display Microsoft's websites; they are **not native Linux desktop versions** of Word, Excel, PowerPoint, Teams, or OneDrive. If you prefer, open Firefox and visit [Microsoft 365](https://www.microsoft365.com/), [Teams](https://teams.microsoft.com/), or [OneDrive](https://onedrive.live.com/) directly.

## Open Edge manually

After installation, choose **Microsoft Edge** from Applications or the dock. From a terminal, run:

```bash
microsoft-edge-stable
```

To open a Microsoft 365 web app directly in Edge's app-style window:

```bash
microsoft-edge-stable --app=https://www.microsoft365.com/
```

## Remove the integration

Remove the shortcuts from `~/.local/share/applications/plainnix-*.desktop` and `~/.config/plank/dock1/launchers/plainnix-*.dockitem`. To uninstall Edge and remove its APT source/key:

```bash
sudo apt remove microsoft-edge-stable
sudo rm -f /etc/apt/sources.list.d/microsoft-edge.list /etc/apt/keyrings/microsoft-edge.gpg
sudo apt update
```

This removes Edge's repository configuration; the shortcuts are kept separate so you can remove or retain them as you prefer.
