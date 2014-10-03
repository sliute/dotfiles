Luke's Chef configuration
=========================

This repository contains my Chef Solo configuration. I use this repository to
initially configure all of my machines, then I'll periodically update it with
configuration changes and re-run it to ensure that all of my machines are
configured as close to identically as possible. This set up enables me to be
productive and avoid screwing around in terminals fixing configuration in paid
time ;-)

What's included
---------------

* Batteries ;-)
* Bash - a microframework for loading configuration, pretty default prompt
* Carrier Repo - a private Yum repo I'm hosting with handy packages (including
  a wrapper around ST3)
* DNF - configuration for the Yum-replacement package manager, including COPR
  (like Ubuntu's PPAs)
* Git - a few nifty aliases, also configures your identity
* Gnome Terminal - custom colour scheme, run as login shell
* KeepassX - secure password management
* LAMP development environment - with ```mod_userdir``` and ```mod_suphp```
* Less - with added syntax highlighting!
* Meld - awesome diff tool
* Mosh - ideal if your employer's WiFi is way oversold
* Moodle development environment (just Shifter for now)
* Node - plus Shifter, purely for my own selfish needs
* OwnCloud client - file syncing and web apps on your own terms
* Ruby - ```rbenv``` configuration
* Redshift - your eyes are important, don't screw them up
* Skype - handy for meetings with clients
* Sublime Text - courtesy of my own RPM specs, with my preferred theme
* Vim - I'm going to bring back my Vimrc soon
* VirtualBox - run all your Windows apps and testing environments
* VLC - play all the things
* XChat - ```irssi``` just doesn't do it for me

Prerequisites
-------------

Install Chef and Librarian-Chef on your machine and make sure ```chef-solo```
is on your ```$PATH```.

    $ sudo yum install -y bash curl
    $ curl -L https://www.opscode.com/chef/install.sh | sudo bash
    $ sudo /opt/chef/embedded/bin/gem install librarian-chef

You'll then need to fetch the dependencies:

    $ /opt/chef/embedded/bin/librarian-chef install

You'll also want to ensure you've customised your attributes, as by default
you'll end up impersonating me and attempting to download my configuration files
and licenses (which will fail).

Execution
---------

Just run ```chef-solo``` with your desired configuration.

    $ sudo chef-solo -c solo.rb -j configs/<config>.json
