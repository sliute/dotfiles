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
* Git - a few nifty aliases, also configures your identity
* Gnome 3.12  - just a quick precursor to F21 :fast_forward:
* Gnome Terminal - custom colour scheme, run as login shell
* LAMP development environment - with ```mod_userdir``` and ```mod_suphp```
* Less - with added syntax highlighting!
* Mosh - ideal if your employer's WiFi is way oversold
* Meld - awesome diff tool
* Moodle development environment (just Shifter for now)
* Node - plus Shifter, purely for my own selfish needs
* ```rbenv``` - for sane Rubyists
* Redshift - your eyes are important, don't screw them up
* Sublime Text - courtesy of my own RPM specs, with my preferred theme
* VirtualBox - for stupid applications
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
