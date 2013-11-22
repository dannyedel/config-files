#!/bin/bash
# alias mp='mplayer -ac , -ao alsa:device=default -af volnorm=2:0.25 -softvol -softvol-max 500'
# alias mp='mplayer -ac , -ao alsa:device=default -mixer-channel Front -af ladspa=/usr/lib/ladspa/sc1_1425.so:sc1:2:500:-30:10:1:18 '	
alias mpdef='mplayer -ac , -ao alsa:device=default '	
	#  -af volnorm=2:0.5'
alias mplayer25='mplayer -ac , -channels 6 -speed 25/24 -af lavcac3enc=1:640:2'
alias rm='rm -vi'
alias mv='mv -vi'
alias cp='cp -vi'
alias telnets='openssl s_client -verify 2 -CApath /etc/ssl/certs -connect'

# Start X-Server and logout from terminal
alias sx='nohup startx &>/dev/null & exit'

alias ls='ls --color=auto'
alias ll='ls -l'

export PATH=~/bin:$PATH

DEBMAIL=mail@danny-edel.de
DEBFULLNAME="Danny Edel"
export DEBMAIL
export DEBFULLNAME

alias dquilt="quilt --quiltrc=~/.quiltrc-dpkg"

if  [ -d /opt/trinity/bin ] ; then
	export PATH=$PATH:/opt/trinity/bin
fi
