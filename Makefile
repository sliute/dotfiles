TOP := $(dir $(CURDIR)/$(word $(words $(MAKEFILE_LIST)), $(MAKEFILE_LIST)))

.PHONY: gnome_terminal sublime_text

gnome_terminal:
	dconf dump /org/gnome/terminal/ \
	      >$(TOP)cookbooks/lukecarrier/files/default/gnome_terminal
