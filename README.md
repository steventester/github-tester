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


## TODOs
1. Lean up zshrc
2. Setup dotfile management
3. [Emacs] Rust, R and python environments and ripgrep plugin
   - setup daemon emacs.
4. Setup gnome keyring and ssh keys (see [gnome keyring](https://wiki.archlinux.org/index.php/GNOME/Keyring) and [pam](https://wiki.archlinux.org/index.php/PAM))
5. Setup Security - look [here](https://wiki.archlinux.org/index.php/List_of_applications/Security)
   - password management [here](https://nickjanetakis.com/blog/managing-your-passwords-on-the-command-line-in-linux-with-pass) and [here](https://wiki.archlinux.org/index.php/Pass)
   - Setup lockscreen
