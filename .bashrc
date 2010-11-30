# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

if [ "$OSTYPE" == "darwin9.0" ]; then
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
    export MANPATH=/opt/local/share/man:$MANPATH
fi

# export PATH=/var/lib/gems/1.8/bin:"${PATH}"
# export PATH=~/bin:~/.cabal/bin:~/lib/flex3/bin:"${PATH}"
export PATH=~/bin:~/opt/bin:~/.cabal/bin:~/.seeds/bin:/var/lib/gems/1.8/bin/:"${PATH}"
# export PYTHONPATH=~/src/pygments:~/workspace:~/src/pyglet:"${PYTHONPATH}"

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
export HISTFILESIZE=5000

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
    # local RED="\033[1;31m"
    # local NO_COLOUR="\033[0m"
    branch_prompt=$(my__git_ps1 "$@")
    if [ -n "$branch_prompt" ]; then
        current_git_status=$( git status -s )
        if dirty=$( echo "$current_git_status" | grep '^.M' 2> /dev/null); then
            branch_prompt="$branch_prompt*"
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

alias ll="ls -laF"
alias h?="history | grep $1"
alias g='ack-grep'

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
# [ -z "$PS1" ] && return

if [ "$OSTYPE" != "darwin9.0" ]; then
    keychain -q -Q ~/.ssh/id_dsa && sh ~/.keychain/${HOSTNAME}-sh
fi

# IPTEGO stuff
export IPTEGOPATH="/home/simon/workspace"
export VSP="$IPTEGOPATH/vsp"
# export PYTHONPATH="$IPTEGOPATH:$IPTEGOPATH/libp:$IPTEGOPATH/scriptingd:$IPTEGOPATH/palladion/libpalladion/trunk:$IPTEGOPATH/palladion/vsi/trunk/bin:$VSP"

export LD_LIBRARY_PATH=$IPTEGOPATH/palladion/json-c/.libs/:$IPTEGOPATH/palladion/libtpl/src/.libs/

export LESS="-RMg"
alias svndiff='svn diff|colordiff|less'
alias pld-start="sudo python $IPTEGOPATH/screen/screen-trunk.py"
alias vsp-dbconsole="mysql -u root vsp"

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
alias rt="refresh_tags"
alias google-chrome-dev="google-chrome --user-data-dir=$HOME/.config/google-chrome/dev/"

source /home/simon/src/git-svn-extensions/source.sh
export WORKON_HOME=~/workspace/envs
# source `which virtualenvwrapper.sh`

# Automatically activate Git projects' virtual environments based on the
# directory name of the project. Virtual environment name can be overridden
# by placing a .venv file in the project root with a virtualenv name in it
function workon_cwd {
    # Check that this is a Git repo
    GIT_DIR=`git rev-parse --git-dir 2> /dev/null`
    if [ $? == 0 ]; then
        # Find the repo root and check for virtualenv name override
        GIT_DIR=`\cd $GIT_DIR; pwd`
        PROJECT_ROOT=`dirname "$GIT_DIR"`
        ENV_NAME=`basename "$PROJECT_ROOT"`
        if [ -f "$PROJECT_ROOT/.venv" ]; then
            ENV_NAME=`cat "$PROJECT_ROOT/.venv"`
        fi
        # Activate the environment only if it is not already active
        if [ "$VIRTUAL_ENV" != "$WORKON_HOME/$ENV_NAME" ]; then
            if [ -e "$WORKON_HOME/$ENV_NAME/bin/activate" ]; then
                workon "$ENV_NAME" && export CD_VIRTUAL_ENV="$ENV_NAME"
            fi
        fi
    elif [ $CD_VIRTUAL_ENV ]; then
        # We've just left the repo, deactivate the environment
        # Note: this only happens if the virtualenv was activated automatically
        deactivate && unset CD_VIRTUAL_ENV
    fi
}

# New cd function that does the virtualenv magic
# function venv_cd {
    # cd "$@" && workon_cwd
# }

# alias cd="venv_cd"

function checkjs {
	java -jar ~/lib/compiler.jar --js $@ --js_output_file /dev/null
}

