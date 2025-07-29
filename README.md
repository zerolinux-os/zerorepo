# ZeroRepo

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)](https://github.com/zerolinux-os/zerorepo)

ZeroRepo is a comprehensive custom package repository for the [ZeroLinux](https://github.com/zerolinux-os) distribution, an Arch Linux-based operating system. This repository provides a curated collection of packages across multiple categories, streamlining the setup and customization process for ZeroLinux users.

## 🚀 Features

- **Automated Package Management**: Automatically fetches official Arch packages and builds AUR packages
- **Unified Repository Structure**: Organizes all packages into a coherent directory structure
- **Database Integration**: Updates repository database for seamless pacman integration
- **Multi-Category Support**: Includes packages for development, security, networking, theming, and more
- **KDE Plasma Integration**: Complete KDE Plasma desktop environment packages
- **Easy Installation**: Simple script-based setup process

## 📦 Package Categories

### Development & Programming
Tools and libraries for software development, including IDEs, compilers, and programming language support.

### Information Security & Ethical Hacking
Comprehensive collection of penetration testing tools, vulnerability scanners, and security utilities.

### Networking
Network analysis, monitoring, and configuration tools for system administrators and security professionals.

### Base System & Utilities
Essential system utilities, file managers, and core applications for daily use.

### Distribution Building Tools
Specialized tools for building and customizing Linux distributions.

### Theming & Appearance
Visual customization packages including themes, icons, and desktop appearance modifications.

### KDE Plasma & GUI Packages
Complete KDE Plasma desktop environment with additional GUI applications and utilities.

### Repository & Automation Tools
Package management and automation utilities for maintaining the repository.

## 🛠️ Prerequisites

Before using ZeroRepo, ensure you have the following installed:

- `yay` (AUR helper)
- `pacman` (Package manager)
- `repo-add` (Repository database tool)
- Sufficient disk space for package downloads and builds
- Sudo privileges for package operations

## 📥 Installation

### 1. Clone the Repository
```bash
git clone https://github.com/zerolinux-os/zerorepo.git
cd zerorepo
```

### 2. Run the Build Script
```bash
bash build_zerorepo.sh
```

### 3. Add Repository to Pacman Configuration
Add the following to your `/etc/pacman.conf`:

```ini
[zerorepo]
SigLevel = Optional TrustAll
Server = file:///repo/zerorepo/x86_64
```

### 4. Update Package Database
```bash
sudo pacman -Sy
```

## 🔧 Usage

After installation, you can install packages from ZeroRepo using standard pacman commands:

```bash
# Search for packages
pacman -Ss package-name

# Install packages
sudo pacman -S package-name

# Update all packages
sudo pacman -Syu
```

## ⚠️ Important Notes

- Some AUR packages may require manual intervention during the build process
- The build script requires sudo privileges for downloading official packages
- Building all packages may take considerable time depending on your system specifications
- Review and customize the package lists in the build script according to your needs
- Ensure you have adequate storage space before running the build process

## 🤝 Contributing

We welcome contributions to improve ZeroRepo! Here's how you can help:

1. **Report Issues**: Found a bug or have a suggestion? Open an issue on GitHub
2. **Submit Pull Requests**: Want to add a feature or fix a bug? Submit a PR
3. **Package Requests**: Need a specific package? Open an issue with the package details
4. **Documentation**: Help improve our documentation and guides

### Development Guidelines

- Follow existing code style and conventions
- Test your changes thoroughly before submitting
- Update documentation when adding new features
- Include clear commit messages describing your changes

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🌟 Acknowledgments

- **Arch Linux Community**: For providing the solid foundation and extensive package ecosystem
- **AUR Maintainers**: For their dedication to maintaining community packages
- **KDE Project**: For the excellent Plasma desktop environment
- **Open Source Community**: For the tools and libraries that make this project possible

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/zerolinux-os/zerorepo/issues)
- **Discussions**: [GitHub Discussions](https://github.com/zerolinux-os/zerorepo/discussions)
- **ZeroLinux Project**: [Main Repository](https://github.com/zerolinux-os)

## 🔄 Version History

See [Releases](https://github.com/zerolinux-os/zerorepo/releases) for a detailed changelog of all versions.

---

**Made with ❤️ by the ZeroLinux Team**
