export PATH=~/bin:/usr/local/sbin:/usr/local/bin:~/.cabal/bin:/usr/local/share/npm/bin:./node_modules/.bin:/Users/simon/weave/bin:~/Library/Python/3.7/bin:"${PATH}"


# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
export HISTFILESIZE=100000
export HISTSIZE=100000
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
alias g="`which ag` -S"

function ps? {
    ps aux | grep -i "$@"
}

function gc {
    eval "awk '{ print \$$1; }'"
}

function slugify {
  iconv -t ascii//TRANSLIT | sed -E 's/[~\^]+//g' | sed -E 's/[^a-zA-Z0-9]+/-/g' | sed -E 's/^-+\|-+$//g' | tr A-Z a-z
}
export -f slugify

trim() {
  awk '{$1=$1};1'
}
export -f trim

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

# export NODE_PATH=/usr/local/lib/jsctags/:$NODE_PATH
# alias vim='mvim -v'


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if which brew > /dev/null; then
	[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
fi

alias nw="/Applications/node-webkit.app/Contents/MacOS/node-webkit"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

alias p4diff="/Applications/p4merge.app/Contents/Resources/launchp4merge"
alias lein="rlwrap lein"
alias planck="rlwrap planck"

# export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)
# setjdk() {
  # export JAVA_HOME=$(/usr/libexec/java_home -v $1)
# }
# setjdk 1.8

export GOPATH=/Users/simon/weave
export AWS_DEFAULT_REGION=eu-central-1

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

export PATH="/usr/local/opt/gdal2/bin:$PATH"

export PATH="$HOME/.yarn/bin:$PATH"

export FZF_DEFAULT_OPTS='--bind ctrl-j:accept'
export FZF_DEFAULT_COMMAND='fd --type f'

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

source ${HOME}/google-cloud-sdk/completion.bash.inc
source ${HOME}/google-cloud-sdk/path.bash.inc

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
    eval "$("$BASE16_SHELL/profile_helper.sh")"
base16_default-dark
export PATH="/usr/local/opt/go@1.10/bin:$PATH"

eval "$(direnv hook bash)"

# fh - repeat history
fh() {
	  eval -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
  }

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

