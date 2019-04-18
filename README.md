<p align="center">
  <img src="logo/1024px.png" alt="ubuntu_install" height="200px">
  </br>
  <em> Logo designed by <a href="https://github.com/familqasimov">Famil Qasimov</a> </em>
</p>


ubuntu install
===========
[![environment](https://img.shields.io/badge/linux-ubuntu_18.04-orange.svg)](https://img.shields.io/badge/linux-ubuntu_18.04-orange.svg) [![environment](https://img.shields.io/badge/language-ansible-2196F3.svg)](https://img.shields.io/badge/tool-ansible-2196F3.svg) [![environment](https://img.shields.io/badge/language-shell-43A047.svg)](https://img.shields.io/badge/tool-ansible-2196F3.svg)

## Description
Install my firsts packages and make initial configs in a Ubuntu formatted. Its recommended Ubuntu 18.04 Minimal Installation.

OBS: The most of the installation is done by [Ansible](https://github.com/ansible/ansible)

The installation is divided in 3 parts

> 1. Base

This installation contains a principal packages and only kind of intallattion triggered by [``trigger.sh``](https://raw.githubusercontent.com/frankjuniorr/ubuntu_install/master/code/trigger.sh)

> 2. Optional

This installation contains others kind of packages not so importants to initial setup (ex. Telegram, LibreOffice and Transmission)

> 3. Development

TODO

## Base Installation

### 1. Initial Upgrade
Make the initial config with `sudo apt upgrade && sudo apt dist-upgrade`
### 2. Install packages
Install many packages. Basically the packages are:
- Spotify
- Visual Studio Code
- Some tools like: git, vim, meld, curl, wget and others stuffs
- Dropbox
- Google Chrome
- Terminator
- Some dark themes and others Gnome customizations

### 3. Clean dependencies
Clean packages with `sudo apt -f -y install` to fix broken packages and `sudo apt-get autoremove && sudo apt-get clean` to clean.
### 4. Download my dotfiles
Download my [Dotfiles repository](https://github.com/frankjuniorr/dotfiles), but not install, only download. Because of my dotfiles installation is necessary the user interation.

## Install without git in a Ubuntu formatted
```bash
wget -O - https://git.io/fjqyx | bash
```
This shorten link ``https://git.io/fjqyx`` is pointed to ``https://raw.githubusercontent.com/frankjuniorr/ubuntu_install/master/code/trigger.sh``

# Screenshots after installation

#### Theme:

- [Adapta GTK Theme](https://github.com/adapta-project/adapta-gtk-theme)
- [Korla Icon Theme](https://github.com/bikass/korla)

#### Extensions:

- [Hide Activities](https://extensions.gnome.org/extension/1128/hide-activities-button/)
- [Move Clock](https://extensions.gnome.org/extension/2/move-clock/)
- [OpenWeather](https://extensions.gnome.org/extension/750/openweather/)


### Desktop:

<img alt="Icon" src="screenshot/screenshot_desktop.png?raw=true" align="center" hspace="1" vspace="1">

### Lock Screen:

* The image is same wallpaper, but is blur

<img alt="Icon" src="screenshot/screenshot_lockscreen.png?raw=true" align="center" hspace="1" vspace="1">

### Login Screen:

* The ``ubuntu_install`` set my user profile picture too =D

<img alt="Icon" src="screenshot/screenshot_login.png?raw=true" align="center" hspace="1" vspace="1">
