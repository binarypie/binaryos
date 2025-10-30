#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# hyprland COPR from solopasha
dnf5 -y copr enable solopasha/hyprland
dnf5 -y install xdg-desktop-portal-hyprland hyprland hyprland-contrib hyprland-plugins hyprpaper hyprpicker hypridle hyprshot hyprlock pyprland waybar-git xdg-desktop-portal-hyprland hyprland-qtutils

# Walker
dnf5 -y copr enable errornointernet/walker
dnf5 -y install walker
dnf5 -y install elephant

# swayosd
dnf5 -y copr enable markupstart/SwayOSD
dnf5 -y install swayosd

# other related packages found in main Fedora repos:
dnf5 -y install mako swaybg

# Wezterm
dnf5 -y copr enable wezfurlong/wezterm-nightly
dnf5 -y install wezterm

# Neovim
dnf5 -y copr enable agriffis/neovim-nightly
dnf5 -y install neovim python3-neovim

# systemctl enable podman.socket

### BinaryOS Branding
# os-release file for OS Version
rsync -rvK /ctx/system_files/ /

# Neutral spinner theme
plymouth-set-default-theme spinner -R 2>/dev/null || true
