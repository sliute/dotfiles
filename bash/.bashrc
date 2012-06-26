# Source global definitions
[ -f /etc/bashrc ] && . /etc/bashrc

# Shell prompt
#
# Inspired by http://brettterpstra.com/my-new-favorite-bash-prompt/
prompt_command () {
    # If the last command failed, show its non-zero exit code
    [ $? -ne 0 ] && local ERRPROMPT="[\$?] "

    # If we're in a Git repo, show our current branch
    [ "$(type -t __git_ps1)" ] && local BRANCH="\$(__git_ps1 '[%s] ')"

    # If we're using RVM, tell us what environment we're in
    local RVM_ENV="\$(fmt_rvm_env)"

    # Current time and system load
    local TIME="$(fmt_time)"
    local LOAD="$(awk '{print $1}' /proc/loadavg)"

    # Pretty colours
    local BLACK="\[\033[0;30m\]"
    local BLUE="\[\033[0;34m\]"
    local BROWN="\[\033[0;33m\]"
    local CYAN="\[\033[0;36m\]"
    local DARK_GRAY="\[\033[0;30m\]"
    local GREEN="\[\033[0;32m\]"
    local LIGHT_BLUE="\[\033[0;34m\]"
    local LIGHT_CYAN="\[\033[0;36m\]"
    local LIGHT_GREEN="\[\033[0;32m\]"
    local LIGHT_GRAY="\[\033[0;37m\]"
    local LIGHT_PURPLE="\[\033[0;35m\]"
    local LIGHT_RED="\[\033[0;31m\]"
    local PURPLE="\[\033[0;35m\]"
    local RED="\[\033[0;31m\]"
    local YELLOW="\[\033[0;33m\]"
    local WHITE="\[\033[0;37m\]"
    local DEFAULT="\[\033[0;39m\]"

    export PS1="${RED}${ERRPROMPT}\
${LIGHT_CYAN}[\u@\h] \
${WHITE}[${LOAD}@${TIME}] \
${BROWN}[\w]\n\
${GREEN}${BRANCH}\
${RED}${RVM_ENV}\
${DEFAULT}$ "
}

PROMPT_COMMAND=prompt_command

fmt_time () {
    [ "$(date +%p)" = "PM" ] && local meridiem="pm" || local meridiem="am"
    date +"%l:%M:%S$meridiem" | sed 's/ //g'
}

fmt_rvm_env () {
    local e="$(rvm-prompt)"
    [ -n "$e" ] && echo "[${e}]"
}

