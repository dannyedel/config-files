# Erstelle eine Liste aller Dateien im Format home_dot/.XXX
# Ausnahme: ..
#
DOT_FILES=$(wildcard home_dot/.[a-zA-Z]*)
NODOT_FILES=$(wildcard home_nodot/[a-zA-Z]*)
CONFIG_FILES=$(wildcard dotconfig_*)
HOSTNAME=$(shell hostname)

HOSTSPEC_DOT_FILES=$(wildcard hostspecific/$(HOSTNAME)/home_dot/.[a-zA-Z]*)

HOME_DOT_FILES=$(patsubst home_dot/.%,~/.%,$(DOT_FILES))
HOME_NODOT_FILES=$(patsubst home_nodot/%,~/%,$(NODOT_FILES))
HOME_CONFIG_FILES=$(patsubst dotconfig_%,~/.config/%,$(CONFIG_FILES))

HOSTSPEC_HOME_DOT_FILES=$(patsubst hostspecific/$(HOSTNAME)/home_dot/.%,~/.%,$(HOSTSPEC_DOT_FILES))

all: $(HOME_DOT_FILES) $(HOME_NODOT_FILES) $(HOSTSPEC_HOME_DOT_FILES) $(HOME_CONFIG_FILES)


# Erzeuge ~/.FILENAME als Symlink auf $PWD/home_dot_filename
~/.%: home_dot/.%
	# Zieldatei loeschen, wenn bereits ein Symlink ist (evtl zum falschen Ziel)
	- test -L $@ && rm -f $@
	# Abbruch falls Ziel noch existiert (also kein Symlink war)
	test ! -e $@
	# Symlink anlegen
	ln -s $(PWD)/$< $@

~/.config/%: dotconfig_%
	- test -L $@ && rm -f $@
	mkdir -p ~/.config
	test ! -e $@
	ln -s $(PWD)/$< $@



# Erzeuge ~/FILENAME als Symlink auf $PWD/home_nodot_filename
~/%: home_nodot/%
	# Zieldatei loeschen, wenn bereits ein Symlink ist (evtl zum falschen Ziel)
	- test -L $@ && rm -f $@
	# Abbruch falls Ziel noch existiert (also kein Symlink war)
	test ! -e $@
	# Symlink anlegen
	ln -s $(PWD)/$< $@

~/.%: hostspecific/$(HOSTNAME)/home_dot/.%
	# Zieldatei loeschen, wenn bereits ein Symlink ist (evtl zum falschen Ziel)
	- test -L $@ && rm -f $@
	# Abbruch falls Ziel noch existiert (also kein Symlink war)
	test ! -e $@
	# Symlink anlegen
	ln -s $(PWD)/$< $@

