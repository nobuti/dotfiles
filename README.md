Requirements
------------

Set zsh as your login shell.

    chsh -s /bin/zsh

Install
-------

First, create symlinks for ssh credentials, usually backed up in Dropbox. Remove any .zshrc or .bin folder. Pay attention for possible changes or aditions. Try to stay update this dotfiles.

    cd dotfiles
    ./install.sh

This will create symlinks for config files in your home directory. 

Credits
-------

![thoughtbot](http://thoughtbot.com/images/tm/logo.png)