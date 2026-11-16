# PlainNix
A lightweight, Debian-based Linux system focused on simplicity, familiar shell workflows, and beginner-friendly documentation.

PlainNix is designed to feel comfortable to newcomers while staying light enough for older hardware and minimal installs. The project is intentionally practical: a clean Debian base, a small curated package set, and a shell-first experience that avoids unnecessary complexity.

## Goals

- Keep the base system small and understandable
- Use Debian packages and familiar package management
- Favor simple command-line workflows over flashy desktop complexity
- Make setup and maintenance easy for beginners
- Provide a clear, documented system that is easy to extend

## System vision

PlainNix aims to be a polished but minimal Linux distribution with:

- Debian as the foundation
- a lightweight desktop or console environment
- common GNU/Linux tools installed by default
- beginner-friendly configuration files and scripts
- predictable package selection and a sane default layout

## Project structure

- `scripts/bootstrap.sh` — installs the base Debian system and core utilities
- `scripts/first-boot.sh` — sets up the default user experience after installation
- `config/packages.txt` — curated package manifest for the base system
- `docs/architecture.md` — design notes and system architecture

## Quick start

1. Boot into a Debian installer or live environment.
2. Clone or copy this repository onto the target machine.
3. Run:

```bash
sudo ./scripts/bootstrap.sh
```

4. Reboot, then run:

```bash
./scripts/first-boot.sh
```

## Default philosophy

PlainNix is not trying to be a huge, opinionated desktop ecosystem. It is a clean, stable, shell-friendly Debian-based operating system for people who want to stay close to the command line and keep things easy to understand.

## Roadmap

- Minimal Debian base install
- lightweight desktop option
- better onboarding and documentation
- system configuration templates for common workloads
- simple package customization workflow

## License

This project is an open starter template for a lightweight Debian-based Linux system. Adapt and redistribute it under the terms of your preferred open-source license.
