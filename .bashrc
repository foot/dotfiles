# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary, # update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
    # PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

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


alias loadkeys='keychain -q -Q ~/.ssh/id_dsa'
alias rsynctestdata='rsync -ave ssh simon.howe@muddy2:/home/gridmo/testdata/ /home/gridmo/testdata/'
# alias more='less'

alias bt='ctags -R . ; etags -R . ; echo "refreshed tags"'

alias ll="ls -laF"
alias h?="history | grep $1"
alias gvim="mvim"

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
fi

function ps? {
    ps aux | grep "$@"
}
function gc {
    eval "awk '{ print \$$1; }'"
}

function g {
    echo "================================================================================"
    #grep --color -n "$@" `find . -name "*.as"`
    grep --color -n "$@" `find . ! -path "*.svn/*" ! -name ".svn" ! -name "*.swp" ! -name "*.pyc" ! -path "./tags" ! -path "./client-debug-compilation.log"`
    #ack "$@"
    echo "================================================================================"
}

export PATH=~/bin:"${PATH}"
export PYTHONPATH=~/src/pygments:$PYTHONPATH:~/workspace:~/src/pyglet
export CLASSPATH="${CLASSPATH}:/home/simonhowe/downloads/java/jdk1.5.0_14/jre/lib/plugin.jar" # :/usr/lib/jvm/java-6-sun-1.6.0.03/jre/lib/plugin.jar"
export PATH=~/lib/flex2/bin:"${PATH}"
if [ -f ~/.tilefile_helpers ]; then
	. ~/.tilefile_helpers
fi
export EDITOR=mvim

loadkeys

