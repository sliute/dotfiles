# Dotfiles

Luke's extraordinarily opinionated Chef configuration. I'd strongly advise not
using this configuration directly, but it might might be an ideal starting point
for your own.

* * *

## Warning

This branch is a work in progress migration from Fedora to Ubuntu and Windows.
I'm also modernising some of the older recipes and migrating to some
community-maintained cookbooks.

## Supported platforms

* Ubuntu Gnome 15.04
* Windows 7 SP1

## Overview

Configuration is divided into three key roles.

### ```base```

Basic system configuration and every day applications.

| Recipe | Linux | Windows |
| --- | --- | --- |
| [Bash shell](https://www.gnu.org/software/bash/) profile | :thumbsup: | |
| [Chromium](https://www.chromium.org/) web browser | :thumbsup: | |
| [Gnome Terminal](https://wiki.gnome.org/Apps/Terminal) configuration | :thumbsup: | |
| [Google Chrome](https://www.google.com/chrome/) | | :thumbsup: |
| [htop](http://hisham.hm/htop/) for inspecting running processes | :thumbsup: | |
| [KeePassX](http://keepassx.info/) password manager | :thumbsup: | :thumbsup: |
| [PowerShell](https://msdn.microsoft.com/en-us/powershell/) configuration | | :thumbsup: |
| [Remote Desktop Connection Manager](https://www.microsoft.com/en-gb/download/details.aspx?id=44989) | | :thumbsup: |
| [Skype](http://skype.com/) client for communication | :thumbsup: | :thumbsup: |
| [VirtualBox](http://virtualbox.org/) for desktop virtualisation | :thumbsup: | :thumbsup: |

### ```development```

All of the runtimes and tools I need for development.

| Recipe | Linux | Windows |
| --- | --- | --- |
| [Atom](http://atom.io/), GitHub's modern take on a text editor | :thumbsup: | :thumbsup: |
| [GIMP](https://www.gimp.org/) image editor | :thumbsup: | |
| [Git](https://git-scm.com/) source code management tools | :thumbsup: | :thumbsup: |
| [gitg](https://wiki.gnome.org/action/show/Apps/Gitg) | :thumbsup: | |
| [Inkscape](https://inkscape.org/) vector image editor | :thumbsup: | |
| [Vagrant](https://www.vagrantup.com/) | :thumbsup: | :thumbsup: |

### ```gaming```

Just in case I one day run out of GitHub issues...

| Recipe | Linux | Windows |
| --- | --- | --- |
| [Steam](http://store.steampowered.com/) client for gaming | :thumbsup: | |

## Prerequisites

Install Chef and ChefDK on your machine. The Development Kit brings in
[Berkshelf](http://berkshelf.com/), with which I manage the community cookbooks.

### Linux

Assuming ```bash``` and ```curl``` are installed and on ```PATH```:

    $ sudo apt-get install -y bash curl
    $ curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -c current -P chefdk

### Windows

[WMF 3.0](https://www.microsoft.com/en-gb/download/details.aspx?id=34595) is
required for the ```Invoke-WebRequest``` PowerShell cmdlet. Once installed,
reboot Windows and launch PowerShell as an administrator:

    > . { Invoke-WebRequest -UseBasicParsing https://omnitruck.chef.io/install.ps1 } `
            | Invoke-Expression; install -channel current -project chefdk

## Execution

First, allow Berkshelf to install our dependencies:

    $ berks vendor

Then run either a specific configuration:

    $ sudo chef-solo -c solo.rb -j configs/<name>.json

Or a specific recipe:

    $ sudo chef-solo -c solo.rb -o <name>
