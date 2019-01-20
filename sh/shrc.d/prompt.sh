# set variable identifying the chroot you work in (used in the prompt below)
# if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
#     debian_chroot=$(cat /etc/debian_chroot)
# fi

# VTE provides enhanced integration between the shell and the hosting terminal
# via escape sequences. This file appears to be installed by default on Ubuntu
# installations.
. /etc/profile.d/vte-2.91.sh

fg_black=$(tput setaf 0)
fg_red=$(tput setaf 1)
fg_green=$(tput setaf 2)
fg_yellow=$(tput setaf 3)
fg_blue=$(tput setaf 4)
fg_magenta=$(tput setaf 5)
fg_cyan=$(tput setaf 6)
fg_white=$(tput setaf 7)
reset=$(tput sgr0)

prompt_command_main() {
    local cmd_exit=$?
    local is_first=$1

    local git_ref="$(__git_ps1 '%s')"
    if [ -n "$git_ref" ]; then
        local git_dir="$(git rev-parse --show-toplevel)"

        local git_dirty=""
        [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && git_dirty="*"
        local git_sha1="$(git rev-parse --short HEAD 2>/dev/null)"

        local git_status_raw="$(git rev-list --count --left-right "@{upstream}"...HEAD 2>/dev/null)"
        local git_status=""
        if [ "$git_status_raw" = "" ]; then
            git_status="!"
        else
            git_status_counts=(${git_status_raw})
            git_behind="${git_status_counts[0]}"
            git_ahead="${git_status_counts[1]}"
            if [ $git_ahead -eq 0 ] && [ $git_behind -eq 0 ]; then
                git_status=" ="
            fi
            [ "$git_behind" -gt 0 ] || [ "$git_ahead" -gt 0 ] && git_status+=" "
            [ "$git_behind" -gt 0 ]                           && git_status+="<${git_behind}"
            [ "$git_behind" -gt 0 ] && [ "$git_ahead" -gt 0 ] && git_status+="|"
            [ "$git_ahead"  -gt 0 ]                           && git_status+="${git_ahead}>"
        fi

        if [ -s "${git_dir}/.git/refs/stash" ]; then
            local git_stashed=$(git stash list 2>/dev/null | wc -l)
            git_status+=" (${git_stashed} stashed)"
        fi
    fi

    if [ $cmd_exit -eq 0 ]; then
        cmd_exit=''
    else
        cmd_exit="# => \[${fg_red}\]${cmd_exit}\[${reset}\]\n\n"
    fi

    if [ -n "${git_ref}" ]; then
        git_status="on \[${fg_yellow}\]${git_ref}@${git_sha1}${git_dirty}${git_status}\[${reset}\] "
    fi

    local user="\[${fg_cyan}\]\u\[${reset}\] "
    local host="at \[${fg_green}\]\h\[${reset}\] "
    local dir="in \[${fg_magenta}\]\w\[${reset}\] "

    if [ $is_first -eq 0 ]; then
        echo ''
    else
        export PROMPT_COMMAND="prompt_command_main 0"
    fi
    export PS1="${cmd_exit}${user}${host}${dir}${git_status}\n> "

    if typeset -f __vte_prompt_command >/dev/null; then
        __vte_prompt_command
    fi
}

export PROMPT_COMMAND="prompt_command_main 1"
