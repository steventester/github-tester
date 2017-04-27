# dotfiles
Dotfiles for emacs, bspwm, sxhkd, polybar, mpd, ncmpcpp, zsh and a bunch of other stuff


## Installation
To install, simply clone the repository into a directory of your choice.  
```
git clone https://github.com/yiqiaowang/dotfiles .dotfiles
```

Then, [ Do something to symlink to the correct places ] . _Not yet implemented_

After this is completed, ensure that everything in the following checklist is satisfied.  
#### Post installation checklist
1. Set the MONITOR environment variable to equal the name of the monitor you wish polybar to appear on. Find out with xrandr.





#### Documentation
1. Read [this](https://alexcabal.com/creating-the-perfect-gpg-keypair/) for creating GPG keys.
2. Read [this](https://wiki.archlinux.org/index.php/Pass) and [this](https://sanctum.geek.nz/arabesque/linux-crypto-passwords/) (more detailed) for information about ```pass```.
3. Read [this](https://wiki.archlinux.org/index.php/SSH_keys) for information about SSH keys and ssh-agent.

## TODOs
1. Lean up zshrc
2. Setup dotfile management
3. [Emacs] Rust, R and python environments and ripgrep plugin.
   - setup daemon emacs.
   - consider tmux
   - consider running all shells within emacs
