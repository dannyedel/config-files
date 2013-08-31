# Erstelle eine Liste aller Dateien im Format home_dot_XXX
#
DOT_FILES=$(wildcard home_dot_*)
NODOT_FILES=$(wildcard home_nodot_*)
CONFIG_FILES=$(wildcard dotconfig_*)
HOSTNAME=$(shell hostname)

HOSTSPEC_DOT_FILES=$(wildcard hostspecific/$(HOSTNAME)/home_dot_*)

HOME_DOT_FILES=$(patsubst home_dot_%,~/.%,$(DOT_FILES))
HOME_NODOT_FILES=$(patsubst home_nodot_%,~/%,$(NODOT_FILES))
HOME_CONFIG_FILES=$(patsubst dotconfig_%,~/.config/%,$(CONFIG_FILES))

HOSTSPEC_HOME_DOT_FILES=$(patsubst hostspecific/$(HOSTNAME)/home_dot_%,~/.%,$(HOSTSPEC_DOT_FILES))

all: $(HOME_DOT_FILES) $(HOME_NODOT_FILES) $(HOSTSPEC_HOME_DOT_FILES) $(HOME_CONFIG_FILES)


# Erzeuge ~/.FILENAME als Symlink auf $PWD/home_dot_filename
~/.%: home_dot_%
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
~/%: home_nodot_%
	# Zieldatei loeschen, wenn bereits ein Symlink ist (evtl zum falschen Ziel)
	- test -L $@ && rm -f $@
	# Abbruch falls Ziel noch existiert (also kein Symlink war)
	test ! -e $@
	# Symlink anlegen
	ln -s $(PWD)/$< $@

~/.%: hostspecific/$(HOSTNAME)/home_dot_%
	# Zieldatei loeschen, wenn bereits ein Symlink ist (evtl zum falschen Ziel)
	- test -L $@ && rm -f $@
	# Abbruch falls Ziel noch existiert (also kein Symlink war)
	test ! -e $@
	# Symlink anlegen
	ln -s $(PWD)/$< $@

