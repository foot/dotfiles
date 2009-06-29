# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

if [ "$OSTYPE" == "darwin9.0" ]; then
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
    export MANPATH=/opt/local/share/man:$MANPATH
fi

export PATH=/var/lib/gems/1.8/bin:"${PATH}"
export PATH=~/bin:~/.cabal/bin:~/lib/flex3/bin:"${PATH}"
export PYTHONPATH=~/src/pygments:~/workspace:~/src/pyglet:"${PYTHONPATH}"

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# give back <c-s> to forward search (opposite of c-r)
stty stop undef

function my__git_ps1 {
    local g="$(git rev-parse --git-dir 2>/dev/null)"
    if [ "$g" != "$HOME/.git" -a `pwd` != "$HOME" ]; then
        __git_ps1 "$@"
    fi
}

# Get the name of the branch we are on
function git_prompt_info {
    branch_prompt=$(my__git_ps1 "$@")
    if [ -n "$branch_prompt" ]; then
        current_git_status=$( git status )
        if dirty=$( echo "$current_git_status" | grep 'added to commit' 2> /dev/null); then
            # branch_prompt="$( echo "$branch_prompt" | sed 's/(/\\033[01;31m(\\033[00m/' | sed 's/)/\\033[01;31m)\\033[00m/' )"
            branch_prompt="$branch_prompt*"
        fi
        if behind_by=$( echo "$current_git_status" | grep 'behind .* [0-9]\+ commit' ); then
            behind_by=$( echo "$current_git_status" | grep 'behind .* [0-9]\+ commit' | sed 's/.*\ \([0-9]\+\)\ commit.*/\1/' )
            # branch_prompt="$branch_prompt\\033[01;31m-$behind_by\\033[00m"
        fi
        if ahead_by=$( echo "$current_git_status" | grep 'ahead .* [0-9]\+ commit' ); then
            ahead_by=$( echo "$current_git_status" | grep 'ahead .* [0-9]\+ commit' | sed 's/.*\ \([0-9]\+\)\ commit.*/\1/' )
            # branch_prompt="$branch_prompt\\033[01;32m+$ahead_by\\033[00m"
        fi
        echo -e "$branch_prompt"
    fi
}

function do_ps1 {
    local GRAY="\[\033[1;30m\]"
    local LIGHT_GRAY="\[\033[0;37m\]"
    local CYAN="\[\033[0;36m\]"
    local LIGHT_CYAN="\[\033[1;36m\]"
    local NO_COLOUR="\[\033[0m\]"
    local GREEN="\[\033[01;32m\]"
    local BLUE="\[\033[01;34m\]"
    local LIGHT_BLUE="\[\033[01;36m\]"
    PS1="$GREEN\h$NO_COLOUR:$BLUE\w$NO_COLOUR\$(git_prompt_info \"($LIGHT_BLUE%s$NO_COLOUR)\")\$ "
}

do_ps1

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

if [ "$OSTYPE" != "darwin9.0" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias open='gnome-open'
else
    # check the window size after each command and, if necessary, # update the values of LINES and COLUMNS.
    shopt -s checkwinsize
    alias gvim="mvim"
    export EDITOR=mvim
fi

alias bt='ctags -R . ; etags -R . ; echo "refreshed tags"'
alias ll="ls -laF"
alias h?="history | grep $1"
alias g='grin'

function ps? {
    ps aux | grep "$@"
}
function gc {
    eval "awk '{ print \$$1; }'"
}

function gg () {
   local _gg="$1";
   shift;
   git --git-dir="${_gg}/.git" --work-tree="${_gg}" "$@"
}


# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ "$OSTYPE" != "darwin9.0" ]; then
    keychain -q -Q ~/.ssh/id_dsa && sh ~/.keychain/${HOSTNAME}-sh
fi
