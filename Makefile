TOP := $(dir $(CURDIR)/$(word $(words $(MAKEFILE_LIST)), $(MAKEFILE_LIST)))

.PHONY: gnome_terminal sublime_text

gnome_terminal:
	dconf dump /org/gnome/terminal/ \
	      >$(TOP)cookbooks/lukecarrier/files/default/gnome_terminal

sublime_text:
	cp $(HOME)/.config/sublime-text-3/Packages/User/Preferences.sublime-settings \
	   $(TOP)cookbooks/lukecarrier/files/default/sublime_text_user_preferences
	cp $(HOME)/.config/sublime-text-3/Packages/User/"Package Control.sublime-settings" \
	   $(TOP)cookbooks/lukecarrier/files/default/sublime_text_package_control_preferences
