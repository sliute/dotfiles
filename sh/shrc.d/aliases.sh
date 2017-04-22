# Make some common commands a little more colourful
alias less=/usr/share/vim/vim74/macros/less.sh
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Alert helper
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
