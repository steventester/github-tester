# dotfiles
Dotfiles for emacs, bspwm, sxhkd, polybar, rofi, mpd, ncmpcpp, zsh and a bunch of other stuff

## Installation
1. Install GNU Stow however you wish.

2. To complete the installation, clone the repository into a directory of your choice.  
   ```
   git clone https://github.com/yiqiaowang/dotfiles .dotfiles
   ```
   Then, run ```./dotfiles/init.sh``` to symlink the files.

#### Post installation checklist
Ensure that everything in the following checklist is satisfied.  
1. Set the MONITOR environment variable to equal the name of the monitor you wish polybar to appear on. Find out with xrandr.
2. To enable gpg-agent on boot run ```systemctl --user enable gpg-agent.socket``` and ```systemctl --user enable dirmngr.socket```. Read [this](https://wiki.archlinux.org/index.php/GnuPG#Start_gpg-agent_with_systemd_user) for more details.
3. To enable a lockscreen on wake from suspend, copy the contents of [this](https://gist.github.com/yiqiaowang/df90ddcb4e7900f626421f505acdce67) gist into a file called ```lock-on-wake.service``` in ```/etc/systemd/system/```. Then run ```systemctl enable lock-on-wake```.

#### Documentation
1. Read [this](https://alexcabal.com/creating-the-perfect-gpg-keypair/) for creating GPG keys.
2. Read [this](https://wiki.archlinux.org/index.php/Pass) and [this](https://sanctum.geek.nz/arabesque/linux-crypto-passwords/) (more detailed) for information about ```pass```.
3. Read [this](https://wiki.archlinux.org/index.php/SSH_keys) for information about SSH keys and ssh-agent.
4. We use gpg-agent to as an ssh-agent. Read [this](https://wiki.archlinux.org/index.php/GnuPG#SSH_agent) for more information.

## TODOs
1. Lean up zshrc
2. Write a nice script for symlink initialization (for stow).
3. [Emacs] Rust, R and python environments and ripgrep plugin.
   - setup daemon emacs.
   - consider tmux
   - consider running all shells within emacs
