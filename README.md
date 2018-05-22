ubuntu install
===========
[![environment](https://img.shields.io/badge/linux-ubuntu_18.04-orange.svg)](https://img.shields.io/badge/linux-ubuntu_18.04-orange.svg)

## Description
Install my firsts packages and make initial configs in a Ubuntu formatted. Its recommended Ubuntu 18.04 Minimal Installation.

The installation is divided in 6 parts

### 1. Upgrade Inicial
Make the initial config with `sudo apt upgrade && sudo apt dist-upgrade`
### 2. Add repositories
Add all repositories necessaries to install packages
### 3. Update packages
Make the `sudo apt update` to update repositories added
### 4. Install packages
Install all packages. Basically the packages are:
- Spotify
- Atom
- Some dark themes
- Some tools like: git, vim, meld, curl, wget and others stuffs
- Telegram desktop
- Dropbox
- LibreOffice
- Transmission
- Google Chrome
### 5. Clean dependencies
Clean packages with `sudo apt -f -y install` to fix broken packages and `sudo apt-get autoremove && sudo apt-get clean` to clean.
### 6. Install development environment
call the `development_install.sh` to install dev enviroment, that are:
- Postman
- nodeJs
- npm
- call the `java_install.sh` to install Oracle JDK 8
- Android Studio

## Use
```bash
./ubuntu_install.sh
```
