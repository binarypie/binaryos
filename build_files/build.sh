#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Compositor / Hyprland Utilities
dnf5 -y copr enable solopasha/hyprland
dnf5 -y install xdg-desktop-portal-hyprland hyprland hyprland-contrib hyprland-plugins hyprpaper hyprpicker hypridle hyprshot hyprlock pyprland xdg-desktop-portal-hyprland hyprland-qtutils

# Remove extra things
# TODO: Figure out what we don't need from solopasha/hyprland
#
# GUI Shell
dnf5 -y copr enable killcrb/ashell
dnf5 -y install ashell

# Application Launcher
dnf5 -y copr enable errornointernet/walker
dnf5 -y install walker
dnf5 -y install elephant

# On Screen Display
dnf5 -y copr enable markupstart/SwayOSD
dnf5 -y install swayosd

# Desktop Notifications
dnf5 -y install mako
systemctl --global mask mako.service

# Terminal
dnf5 -y copr enable wezfurlong/wezterm-nightly
dnf5 -y install wezterm

# Editor
dnf5 -y copr enable agriffis/neovim-nightly
dnf5 -y install neovim python3-neovim

# Install binaryos config setup script and service
install -Dm755 /ctx/binaryos-config /usr/bin/binaryos-config
install -Dm644 /ctx/binaryos-config.service /usr/lib/systemd/user/binaryos-config.service

# Enable hyprland config setup service
systemctl --global enable binaryos-config.service

# systemctl enable podman.socket
