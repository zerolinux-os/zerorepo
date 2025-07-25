#!/bin/bash
#
# ZeroRepo Builder Script
# Automates the process of fetching official packages and building AUR packages.
#

set -e # Exit immediately if a command exits with a non-zero status.

# --- Configuration ---
REPO_BASE_DIR="$HOME/ZeroRepo"
TARGET_DIR="$REPO_BASE_DIR/x86_64"
REPO_NAME="zerorepo"

# --- Package Lists ---

# Development
DEV_PKGS=(
    base-devel git make gcc cmake meson ninja gdb
    python python-pip python-virtualenv ipython jupyterlab
    jdk-openjdk openjdk-doc maven gradle
    clang lldb valgrind glibc lib32-glibc
    nodejs npm yarn nvm
    rust cargo rust-analyzer
    go gopls
    live-server sassc http-server deno nginx php apache
    docker docker-compose podman ansible terraform vagrant kubernetes
    flatpak snapd pkgconf autoconf automake gettext libtool
    code neovim jetbrains-toolbox lite-xl
)

# Infosec & Hacking
INFOSEC_PKGS=(
    metasploit exploitdb recon-ng beef
    nmap masscan nikto zmap whatweb dnsrecon
    aircrack-ng reaver wifite bully
    burpsuite sqlmap dirb ffuf gobuster wfuzz xssstrike
    hydra medusa hashcat john
    searchsploit veil set empire
    radare2 cutter apktool gdb ghidra binwalk strace ltrace
    volatility autopsy sleuthkit foremost scalpel pdf-parser
    bettercap ettercap macchanger dsniff yersinia
)

# Networking
NET_PKGS=(
    net-tools inetutils iproute2 wireguard-tools openvpn networkmanager dhcpcd wpa_supplicant
    tcpdump wireshark-qt iperf3 traceroute mtr whois dig dnsutils
    openssh rsync rclone scp ftp nfs-utils samba
)

# Base & Utility
BASE_PKGS=(
    yay paru pacman-contrib reflector paccache xdg-utils lsb-release btop htop neofetch fastfetch
    bash-completion curl wget zip unzip p7zip nano vim zsh fish grub-customizer gnome-disk-utility
)

# Distro Building
DISTRO_PKGS=(
    archiso mkinitcpio arch-install-scripts calamares squashfs-tools xorriso gparted dosfstools
    mtools parted yaml-cpp qt5-base qt6-base kpmcore polkit-qt5 boost-libs extra-cmake-modules
)

# Theming
THEME_PKGS=(
    papirus-icon-theme breeze-icons numix-icon-theme oxygen-icons arcolinux-icon-themes ars-dark-icons
    kvantum kvantum-theme-materia materia-gtk-theme sweet-gtk-theme-git andromeda-kde breeze-gtk arc-gtk-theme
    plasma-workspace-wallpapers sddm-theme-deepin arcolinux-plasma-themes-git arcolinux-sddm-git
    arcolinux-wallpapers-git
)

# KDE & GUI
KDE_PKGS=(
    plasma-desktop plasma-meta plasma-wayland-session sddm sddm-kcm kde-gtk-config kdeplasma-addons
    dolphin kate konsole ark systemsettings partitionmanager plasma-systemmonitor ksysguard
    okular spectacle gwenview kcalc kdeconnect yakuake
    networkmanager-qt plasma-nm bluedevil
    kwayland frameworkintegration kirigami2 kio kcmutils qt5-tools qt6-tools
    latte-dock kdeplasma-addons plasma-pa plasma-browser-integration
)

# Repo & Automation Tools
REPO_TOOLS=(
    repo-add devtools namcap pacman-contrib pkgbuild-introspection aurutils
    yay paru trizen pkgbuild-lint makepkg debtap
    act gh git-lfs docker rsync git
    archivetools xz gzip zstd tar unsquashfs
)


# Combine all packages into one master list
ALL_PKGS=(
    "${DEV_PKGS[@]}"
    "${INFOSEC_PKGS[@]}"
    "${NET_PKGS[@]}"
    "${BASE_PKGS[@]}"
    "${DISTRO_PKGS[@]}"
    "${THEME_PKGS[@]}"
    "${KDE_PKGS[@]}"
    "${REPO_TOOLS[@]}"
)

# --- Main Logic ---

# 1. Create directory structure
echo "--> Creating repository directory at $TARGET_DIR"
mkdir -p "$TARGET_DIR"

# 2. Separate official and AUR packages
echo "--> Sorting packages into official and AUR lists..."
OFFICIAL_PKGS=()
AUR_PKGS=()

for pkg in "${ALL_PKGS[@]}"; do
    # Check if the package is in the official repos (including chaotic-aur if enabled)
    if pacman -Si "$pkg" &> /dev/null; then
        OFFICIAL_PKGS+=("$pkg")
    else
        AUR_PKGS+=("$pkg")
    fi
done

echo "--> Found ${#OFFICIAL_PKGS[@]} official packages and ${#AUR_PKGS[@]} AUR packages."

# 3. Download official packages
echo "--> Downloading official packages..."
sudo pacman -S --needed --noconfirm --downloadonly "${OFFICIAL_PKGS[@]}"
echo "--> Copying official packages to repo..."
find /var/cache/pacman/pkg/ -name "*.pkg.tar.zst" -exec cp -n {} "$TARGET_DIR/" \;

# 4. Build AUR packages
echo "--> Building AUR packages with yay..."
# We build them one by one to better handle failures
for pkg in "${AUR_PKGS[@]}"; do
    echo "--> Building $pkg..."
    yay -S --noconfirm --aur --needed "$pkg"
done
echo "--> Copying built AUR packages to repo..."
find "$HOME/.cache/yay/" -name "*.pkg.tar.zst" -exec cp -n {} "$TARGET_DIR/" \;


# 5. Create/Update the repository database
echo "--> Updating repository database..."
repo-add "$TARGET_DIR/$REPO_NAME.db.tar.gz" "$TARGET_DIR"/*.pkg.tar.zst

echo "---"
echo "✅ ZeroRepo build process complete!"
echo "Repository is located at: $TARGET_DIR"
echo "To use it, add the following to /etc/pacman.conf:"
echo "[$REPO_NAME]"
echo "SigLevel = Optional TrustAll"
echo "Server = file://$TARGET_DIR"
