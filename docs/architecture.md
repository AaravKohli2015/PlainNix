# PlainNix architecture

PlainNix follows a deliberately simple architecture:

## Core idea

PlainNix is a Debian-based operating system built around a small base system and a familiar shell workflow. The goal is not to reinvent Linux, but to make a version of Debian that feels approachable, low-friction, and easy to maintain.

## Base layer

- Debian stable or testing base
- minimal systemd services enabled by default
- standard apt package management
- no unnecessary desktop extras or heavy software stacks

## User environment

- bash shell
- common utilities such as `curl`, `git`, `less`, `nano`, `grep`, `sed`, `tar`
- optional lightweight desktop stack if the user wants a graphical environment
- clear defaults for shell aliases, directories, and user configuration

## Package philosophy

PlainNix favors:

- tools that are stable and familiar
- common packages with broad compatibility
- minimal dependencies
- beginner-friendly defaults

## Why this works

This approach makes the system easier to debug and easier to learn. It reduces complexity, keeps commands familiar, and gives users a plain Linux environment that still behaves like a real Debian system.

## Typical installation flow

1. Install Debian base system
2. Add required packages from `config/packages.txt`
3. Create a non-root user
4. Configure shell defaults and helpful aliases
5. Enable services and verify the system boot process

## Future directions

- optional XFCE or LXQt desktop profile
- a curated default configuration for development work
- optional secure defaults for servers and workstations
- improved documentation for new users
