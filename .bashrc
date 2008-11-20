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

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

function my__git_ps1 {
    local g="$(git rev-parse --git-dir 2>/dev/null)"
    if [ "$g" != "$HOME/.git" -a `pwd` != "$HOME" ]; then
        __git_ps1 "$@"
    fi
}
PS1='\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(my__git_ps1 "\[\033[00m\] \[\033[01;36m\]%s\[\033[00m\]")\$ '

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

alias bt='ctags -R . ; etags -R . ; echo "refreshed tags"'

alias ll="ls -laF"
alias h?="history | grep $1"

if [ "$OSTYPE" != "darwin9.0" ]; then
	xset b off # kill the bell!
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
	alias open='gnome-open'
	alias gterm='gnome-terminal --hide-menubar&'
else
    if [ -f ~/.keychain/${HOSTNAME}-sh ]; then
        . ~/.keychain/${HOSTNAME}-sh
    fi
    # check the window size after each command and, if necessary, # update the values of LINES and COLUMNS.
    shopt -s checkwinsize
    # bash options
    set completion-ignore-case on
    alias gvim="mvim"
    export EDITOR=mvim
    # alias loadkeys='keychain -q -Q ~/.ssh/id_dsa'
    # loadkeys
    keychain -q -Q ~/.ssh/id_dsa
fi

alias g='grin'
function ps? {
    ps aux | grep "$@"
}
function gc {
    eval "awk '{ print \$$1; }'"
}

if [ -f ~/.tilefile_helpers ]; then
	. ~/.tilefile_helpers
fi

function gg () {
   local _gg="$1";
   shift;
   git --git-dir="${_gg}/.git" --work-tree="${_gg}" "$@"
}

