#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Compositor / Hyprland Utilities
dnf5 -y clean all
dnf5 -y copr enable solopasha/hyprland
dnf5 -y install xdg-desktop-portal-hyprland hyprland hyprland-contrib hyprland-plugins hyprpaper hyprpicker hypridle hyprshot hyprlock pyprland xdg-desktop-portal-hyprland hyprland-qtutils

# CLI Tools
dnf5 -y install fd-find

# Remove extra things
# TODO: Figure out what we don't need from solopasha/hyprland
#
# GUI Shell
dnf5 -y copr enable killcrb/ashell
dnf5 -y install ashell

# Application Launcher - Walker / Elephant
dnf5 -y copr enable errornointernet/packages
dnf5 -y install elephant walker-2.7.2
elephant service enable

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

# Install BinaryOS application configs as system defaults
# XDG-compliant applications will use these as defaults when users first log in

# Hyprland configs
install -Dm644 /usr/share/binaryos/config/hypr/hyprland.conf /usr/etc/xdg/hypr/hyprland.conf
install -Dm644 /usr/share/binaryos/config/hypr/hyprlock.conf /usr/etc/xdg/hypr/hyprlock.conf
install -Dm644 /usr/share/binaryos/config/hypr/hypridle.conf /usr/etc/xdg/hypr/hypridle.conf
install -Dm644 /usr/share/binaryos/config/hypr/hyprpaper.conf /usr/etc/xdg/hypr/hyprpaper.conf

# Install background image to system location
install -Dm644 /usr/share/binaryos/config/hypr/background.webp /usr/share/binaryos/hypr/background.webp

# Fish shell configs
install -Dm644 /usr/share/binaryos/config/fish/config.fish /usr/etc/fish/config.fish
cp -r /usr/share/binaryos/config/fish/conf.d /usr/etc/fish/
cp -r /usr/share/binaryos/config/fish/functions /usr/etc/fish/ 2>/dev/null || true
cp -r /usr/share/binaryos/config/fish/completions /usr/etc/fish/ 2>/dev/null || true

# Neovim configs
cp -r /usr/share/binaryos/config/nvim /usr/etc/xdg/nvim

# Wezterm configs
# Wezterm doesn't support /etc/xdg for system defaults, so we install to /etc/skel
# which will be copied to new user home directories
install -Dm644 /usr/share/binaryos/config/wezterm/wezterm.lua /usr/etc/skel/.config/wezterm/wezterm.lua

# Walker configs
cp -r /usr/share/binaryos/config/walker/themes /usr/etc/xdg/walker/
install -Dm644 /usr/share/binaryos/config/walker/config.toml /usr/etc/xdg/walker/config.toml

# Gitui configs
install -Dm644 /usr/share/binaryos/config/gitui/key_bindings.ron /usr/etc/xdg/gitui/key_bindings.ron

# Elephant configs
install -Dm644 /usr/share/binaryos/config/elephant/elephant.toml /usr/etc/xdg/elephant/elephant.toml

# Ashell configs
install -Dm644 /usr/share/binaryos/config/ashell/config.toml /usr/etc/xdg/ashell/config.toml

# systemctl enable podman.socket
