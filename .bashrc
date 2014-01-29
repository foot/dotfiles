export PATH=~/bin:/usr/local/sbin:/usr/local/bin:~/.cabal/bin:/usr/local/share/npm/bin:./node_modules/.bin/:"${PATH}"


# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
export HISTFILESIZE=10000

# give back <c-s> to forward search (opposite of c-r)
stty stop undef

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -f /Users/simon/src/hg/contrib/bash_completion ]; then
	. /Users/simon/src/hg/contrib/bash_completion
fi

if which brew > /dev/null; then
	if [ -f $(brew --prefix)/etc/bash_completion ]; then
		. $(brew --prefix)/etc/bash_completion
	fi
fi

export GIT_PS1_SHOWUPSTREAM=1
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWSTASHSTATE='verbose'


function do_ps1 {
    local GRAY="\[\033[1;30m\]"
    local LIGHT_GRAY="\[\033[0;37m\]"
    local CYAN="\[\033[0;36m\]"
    local LIGHT_CYAN="\[\033[1;36m\]"
    local NO_COLOUR="\[\033[0m\]"
    local GREEN="\[\033[01;32m\]"
    local BLUE="\[\033[01;34m\]"
    local LIGHT_BLUE="\[\033[01;36m\]"
	PS1="$GREEN\h$NO_COLOUR:$BLUE\w$NO_COLOUR\$(__git_ps1 \"($LIGHT_BLUE%s$NO_COLOUR)\")\$(hg prompt \"($LIGHT_BLUE{branch}{ {status}}$NO_COLOUR)\" 2> /dev/null)\$ "
}

do_ps1

# check the window size after each command and, if necessary, # update the
# values of LINES and COLUMNS.
shopt -s checkwinsize
export EDITOR='vim'
export VISUAL='vim'

alias h?="history | grep $1"
alias g=`which ag`

function ps? {
    ps aux | grep -i "$@"
}

function gc {
    eval "awk '{ print \$$1; }'"
}

export LESS="-RMg"

function refresh_tags {
    local PY_PATHS=(
		"$VSP"
        "$HOME/workspace/libp"
    )
    local PY_FILES=$(find ${PY_PATHS[*]} -name '*.py')
	local JS_FILES=$(cat "$VSP/static/jsfiles.list"|grep ".js"|awk '{ print ENVIRON["VSP"] "/static/js/" $1 }')
    # don't include imports as tags. (--python-kinds=-i)
    ctags --python-kinds=-i $PY_FILES $JS_FILES && echo 'Refreshed tags'
}

[[ $TERM == "xterm" ]] && export -p TERM="xterm-256color"

# source `which virtualenvwrapper.sh`
# workon default

# export NODE_PATH=/usr/local/lib/jsctags/:$NODE_PATH
# alias vim='mvim -v'


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if which brew > /dev/null; then
	[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
fi

alias nw="/Applications/node-webkit.app/Contents/MacOS/node-webkit"

