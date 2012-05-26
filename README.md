lolwut!?
========

These are my configuration files. They make my life simpler. Maybe you'll love
them too?

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

