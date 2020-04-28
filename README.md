<p align="center">
  <img src="logo/1024px.png" alt="ubuntu_install" height="200px">
  </br>
  <em> Logo designed by <a href="https://github.com/familqasimov">Famil Qasimov</a> </em>
</p>

<p align="center">
  <a href="https://img.shields.io/badge/ubuntu-20.04-4A0048.svg">
    <img src="https://img.shields.io/badge/ubuntu-20.04-4A0048.svg?logo=ubuntu">
  </a>
  <a href="https://img.shields.io/badge/ubuntu-18.04-E95420.svg">
    <img src="https://img.shields.io/badge/ubuntu-18.04-E95420.svg?logo=ubuntu">
  </a>
  <a href="https://img.shields.io/badge/language-ansible-2196F3.svg">
    <img src="https://img.shields.io/badge/language-ansible-2196F3.svg?logo=ansible">
  </a>
  <a href="https://img.shields.io/badge/language-shell-43A047.svg">
    <img src="https://img.shields.io/badge/language-shell-43A047.svg">
</p>

## Description
Install the first packages and make my initial configs in a Ubuntu post-installation. Its recommended Ubuntu 20.04.

The project is divided in 2 parts

> 1. Base

This installation contains a principal packages installations and is triggered by [``trigger.sh``](https://raw.githubusercontent.com/frankjuniorr/ubuntu_install/master/code/trigger.sh)

> 2. Optional

This installation contains others kind of packages not so importants to initial setup (e.g. Telegram and Postman)

## Base Installation (steps)

### 1. Initial Upgrade
The script make the initial updates.
### 2. Install packages
Install many packages. Basically the packages are:

| Type | Package |
| ------ | ------ |
| Player | Spotify |
| IDE | VS Code |
| Browser | Google-Chrome |
| Terminal | Terminator |

- Some others tools like:
  - dropbox
  - docker
  - git, git-extras, meld
  - vim , nano
  - curl, wget
  - zip, bzip2, unzip... and other extract packages
  - gnome_tweak-tool
  - neofetch
  - imagemagick
  - and others stuffs

### 3. Download my dotfiles
Download and install my [Dotfiles repository](https://github.com/frankjuniorr/dotfiles).

## Use
```bash
wget -O installer.sh http://bit.ly/2vtw4Ge
chmod +x installer.sh
./installer.sh
```
This shorten link ``http://bit.ly/2vtw4Ge`` is pointed to ``https://raw.githubusercontent.com/frankjuniorr/Ubuntu-Install/master/code/trigger.sh``

----

  ### License:

<p align="left">
  <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">
    <img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /> </a>
  <a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">
    <img src="https://img.shields.io/badge/License-CC_BY--SA_4.0-000000.svg?style=flat-square&logo=creativecommons"/>
  </a>
  
</p>
