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

I'll list the recipes here as I update them.

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

