# ZeroRepo

ZeroRepo is a custom package repository for the [ZeroLinux](https://github.com/zerolinux-os) distribution, which is based on Arch Linux. This repository provides a comprehensive collection of packages across multiple categories, including development tools, infosec & hacking utilities, networking tools, system essentials, distro building, theming, KDE Plasma desktop packages, and repository/automation tools.

## Project Overview

ZeroRepo aims to simplify the setup and customization of ZeroLinux by automating the collection of both official and AUR packages. The included script (`build_zerorepo.sh`) streamlines the process of fetching, building, and organizing all required packages into a local repository, making installation and maintenance faster and easier.

## Features

- Automatically fetches official Arch packages and builds AUR packages.
- Organizes all packages into a unified repository directory structure.
- Updates the repository database for easy integration with pacman.
- Supports a wide variety of categories, including KDE Plasma desktop, development, security, and more.
- Provides clear instructions for adding the repository to your system.

## Usage

1. **Prerequisites:**
    - Make sure you have `yay`, `pacman`, and `repo-add` installed on your system.
    - Sufficient disk space for downloading and building packages.

2. **Run the build script:**
    ```bash
    bash build_zerorepo.sh
    ```
3. **Add the repository to your `/etc/pacman.conf`:**
    ```
    [zerorepo]
    SigLevel = Optional TrustAll
    Server = file:///home/$USER/ZeroRepo/x86_64
    ```

## Supported Categories

- Development & Programming
- Infosec & Hacking
- Networking
- Base System & Utilities
- Distro Building Tools
- Theming & Appearance
- KDE Plasma & GUI Packages
- Repository & Automation Tools

## Notes

- Some packages require manual building via AUR and may take extra time.
- The script requires sudo privileges for downloading official packages.
- Review the package lists in the script to customize your repository as needed.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for more information.

---

## Contributing & Support

Feel free to open Issues or Pull Requests for suggestions, bug reports, or improvements.

---