lolwut!?
========

These are my configuration files. They make my life simpler. Maybe you'll love
them too?

Chef
----

I'm in the process of migrating all of my configuration files into Chef, largely
to ease the pain of migrating between different machines. As I go, I'll be
removing all of the other sections!

My Chef cookbook and Chef Solo environment will get your machine configured in a
matter of seconds. Assuming you're running Ubuntu (or Debian), the following
should do it:

```
$ cd chef
$ sudo ./bootstrap.sh
$ sudo chef-solo -c solo.rb -j configs/<config>.json
```

All the bootstrapper does is installs Chef. If you want to see what it's doing,
you can tail the ``bootstrap.log`` file it writes.

Gnome Terminal
--------------

This is a relatively minor change to use the excellent zenburn colour scheme.
Since Gnome Terminal is configured via GConf, the provided XML file is dump of
the relevant key in GConf. To load it, do the following:

```bash
gconftool-2 --load $HOME/Projects/dotfiles/gnome-terminal/zenburn.xml
```

Vim
---

My Vim configuration is pretty minimal right now; it's only recently that I've
started to make the jump from "traditional" IDEs (yup, I see the irony). To use
it, clone this repository and replace your ``.vimrc`` with:

```viml
let vimconfdir = $HOME . '/Projects/dotfiles/vim'
exec ':source ' . vimconfdir . '/.vimrc'
```

Your ``.vimrc`` is now merely a bootstrap. The ``vimconfdir`` variable is used
within the ``.vimrc`` you just sourced; we use it to locate and initialise
[Pathogen](https://github.com/tpope/vim-pathogen), which in turn loads all of
our plugins.

