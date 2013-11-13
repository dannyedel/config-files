#!/bin/bash
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
umask 077

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# same with ~/bin2
if [ -d "$HOME/bin2" ] ; then
    PATH="$HOME/bin2:$PATH"
fi

# try to launch byobu if it exists
if which byobu-launcher &>/dev/null ; then
	`echo $- | grep -qs i` && byobu-launcher && exit 0
fi
