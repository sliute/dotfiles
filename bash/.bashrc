# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Shell prompt
#
# Inspired by http://brettterpstra.com/my-new-favorite-bash-prompt/
prompt_command () {
    if [ $? -eq 0 ]; then # set an error string for the prompt, if applicable
        ERRPROMPT=" "
    else
        ERRPROMPT='->($?) '
    fi
    if [ "\$(type -t __git_ps1)" ]; then # if we're in a Git repo, show current branch
        BRANCH="\$(__git_ps1 '[ %s ] ')"
    fi

    local TIME=`fmt_time` # format time for prompt string
    local LOAD="$(awk '{print $1}' /proc/loadavg)"
    local GREEN="\[\033[0;32m\]"
    local CYAN="\[\033[0;36m\]"
    local BCYAN="\[\033[1;36m\]"
    local BLUE="\[\033[0;34m\]"
    local GRAY="\[\033[0;37m\]"
    local DKGRAY="\[\033[1;30m\]"
    local WHITE="\[\033[1;37m\]"
    local RED="\[\033[0;31m\]"
    # return color to Terminal setting for text color
    local DEFAULT="\[\033[0;39m\]"
    # set the titlebar to the last 2 fields of pwd
    export PS1="${CYAN}[ ${BCYAN}\u${GREEN}@${BCYAN}\
\h${DKGRAY}(${LOAD}) ${WHITE}${TIME} ${CYAN}]${RED}$ERRPROMPT${GRAY}\
\w\n${GREEN}${BRANCH}${DEFAULT}$ "
}

PROMPT_COMMAND=prompt_command

fmt_time () {
    if [ "$(date +%p)" = "PM" ]; then
        meridiem="pm"
    else
        meridiem="am"
    fi
    date +"%l:%M:%S$meridiem" | sed 's/ //g'
}

