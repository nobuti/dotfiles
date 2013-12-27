thoughtbot dotfiles
===================

Requirements
------------

Set zsh as your login shell.

    chsh -s /bin/zsh

Install
-------

    cd dotfiles
    ./install.sh

This will create symlinks for config files in your home directory. If you
include the line "DO NOT EDIT BELOW THIS LINE" anywhere in a config file, it
will copy that file over instead of symlinking it, and it will leave
everything above that line in your local config intact.

You can safely run `./install.sh` multiple times to update.

Credits
-------

![thoughtbot](http://thoughtbot.com/images/tm/logo.png)