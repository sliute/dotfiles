TOP := $(dir $(CURDIR)/$(word $(words $(MAKEFILE_LIST)), $(MAKEFILE_LIST)))

.PHONY: sublime_text

sublime_text:
	cp $(HOME)/.config/sublime-text-3/Packages/User/Preferences.sublime-settings \
	   $(TOP)cookbooks/lukecarrier/files/default/sublime_text_user_preferences
	cp $(HOME)/.config/sublime-text-3/Packages/User/"Package Control.sublime-settings" \
	   $(TOP)cookbooks/lukecarrier/files/default/sublime_text_package_control_preferences