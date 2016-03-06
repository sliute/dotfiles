# Dotfiles

Luke's extraordinarily opinionated Chef configuration for Ubuntu Gnome 15.10.
I'd strongly advise not using this configuration directly, but it might might be
an ideal starting point for your own configuration.

* * *

## Warning

This branch is an in-progress migration from Fedora to Ubuntu. I'm also
modernising some of the older recipes and migrating to some community-maintained
cookbooks.

## Overview

* ```base``` configuration:
    * Flexible [Bash shell](https://www.gnu.org/software/bash/) profile
    * [Chromium](https://www.chromium.org/) web browser
    * [Gnome Terminal](https://wiki.gnome.org/Apps/Terminal) configuration
    * [KeePassX](http://keepassx.info/) password manager
    * [Skype](http://skype.com/) client for communication
    * [Virtualbox](http://virtualbox.org/) for desktop virtualisation
* ```development``` configuration:
    * [Atom](http://atom.io/), GitHub's modern take on a text editor
    * [GIMP](https://www.gimp.org/) image editor
* ```gaming``` configuration:
    * [Steam](http://store.steampowered.com/) client for gaming

## Prerequisites

Install Chef and ChefDK on your machine. The Development Kit brings in
[Berkshelf](http://berkshelf.com/), with which I manage the community cookbooks:

    $ sudo apt-get install -y bash curl
    $ curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -c current -P chef
    $ curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -c current -P chefdk

## Execution

First, allow Berkshelf to install our dependencies:

    $ berks vendor

Then run either a specific configuration:

    $ sudo chef-solo -c solo.rb -j configs/<name>.json

Or a specific recipe:

    $ sudo chef-solo -c solo.rb -o <name>
