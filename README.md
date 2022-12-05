<p align="center">
  <img src="logo/1024px.png" alt="ubuntu_install" height="200px">
  </br>
  <em> Logo designed by <a href="https://github.com/familqasimov">Famil Qasimov</a> </em>
</p>

<p align="center">
  <a href="https://img.shields.io/badge/ubuntu-22.04-4A0048.svg">
    <img src="https://img.shields.io/badge/-ubuntu_22.04-4A0048.svg?style=for-the-badge&logo=ubuntu&logoColor=white">
  </a>
  <a href="https://img.shields.io/badge/ubuntu-22.04-1d99f3.svg">
    <img src="https://img.shields.io/badge/-kubuntu_22.04-1d99f3.svg?style=for-the-badge&logo=kubuntu&logoColor=white">
  </a>
  <br>
  <a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">
    <img src="https://img.shields.io/badge/-CC_BY--SA_4.0-000000.svg?style=for-the-badge&logo=creative-commons&logoColor=white"/>
  </a>
</p>

## Description
My own config/packages Ubuntu installer that make my initial configs in a Ubuntu post-installation. Its recommended Ubuntu 22.04 or Kubuntu 22.04.

## Base Installation (steps)

### 1. Initial Upgrade
The script make the initial updates.
### 2. Install packages
Install many packages. Basically the packages are:

### Some tools:

| Type | Package |
| ------ | ------ |
| Version Control | git |
| Diff tool | meld |
| CLI text editor | vim |

### Some packages:

| Type | Package |
| ------ | ------ |
| Player | Spotify |
| IDE | VS Code |
| Browser | Google-Chrome |
| Terminal | Terminator |
| Chat | Telegram |
| Password Manager | 1Password |

### Custom Shell:

- zsh
- oh-my-zsh
- powerlevel10k
- colorls
- neofetch
- nerd-fonts

### Some Devops Tools:

| Type | Package |
| ------ | ------ |
| Programming Language | python3 |
| Configuration tool | Ansible |
| Container | Docker |
| Infra as a Code | Terraform |


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

<p align="center">
  <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">
    <img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" />
  </a>
</p>
