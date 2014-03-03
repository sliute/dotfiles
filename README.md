Luke's Chef configuration
=========================

This repository contains my Chef Solo configuration. I use this repository to
initially configure all of my machines, then I'll periodically update it with
configuration changes and re-run it to ensure that all of my machines are
configured as close to identically as possible. This set up enables me to be
productive and avoid screwing around in terminals fixing configuration in paid
time ;-)

Warning
-------

My configuration is presently in the process of being ported to Fedora 20 from
Ubuntu 13.10. This repository therefore contains somewhat broken code, and is
likely to blow up from time to time.

What's included
---------------

* Batteries ;-)
* Bash - a microframework for loading configuration, pretty default prompt
* Git - a few nifty aliases, also configures your identity
* Gnome 3 - a few tweaks for the slickest desktop environment ever
* Gnome Terminal - custom colour scheme, run as login shell
* Last.fm - great application for music discovery
* Java - Oracle JRE/JDK, because no matter how evil, it usually works
* LAMP development environment - with ```mod_userdir``` and ```mod_itk```
* Less - with added syntax highlighting!
* Mosh - ideal if your employer's WiFi is way oversold
* Meld - awesome diff tool
* Node - plus Shifter, purely for my own selfish needs
* ```rbenv``` - for sane Rubyists
* Redshift - your eyes are important, don't screw them up
* Sublime Text - courtesy of my own RPM specs, with my preferred theme
* VirtualBox - for stupid applications
* XChat - ```irssi``` just doesn't do it for me

Prerequisites
-------------

Just install Chef on your machine and make sure ```chef-solo``` is on your
```$PATH```. Although it's a total cop out and Opscode's "engineers" ought to
hang their heads in shame at their own laziness, the Omnibus installer is
presently the easiest way to do this.

    $ sudo yum install -y bash curl
    $ curl -L https://www.opscode.com/chef/install.sh | sudo bash

You'll also want to ensure you've customised your attributes, as by default
you'll end up impersonating me and attempting to download my configuration files
and licenses (which will fail).

Execution
---------

Just run ```chef-solo``` with your desired configuration.

    $ sudo chef-solo -c solo.rb -j configs/<config>.json
