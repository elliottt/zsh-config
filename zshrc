USE_LOCAL_CABAL=y
USE_LOCAL_GHC=ghc7.4.1

# site-wide settings
if [[ -f /etc/zshrc ]]; then
  . /etc/zshrc
fi

# history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt inc_append_history

# local functions
fpath=($fpath ~/.zsh/functions)

# emacs key bindings
bindkey -e

bindkey "^f" forward-word
bindkey "^b" backward-word

# completion
autoload -U compinit colors promptinit spectrum
compinit
colors
spectrum
promptinit

export EDITOR=vim

# Path
if [[ "${USE_LOCAL_CABAL}" = "y" ]]; then
    echo "Using local cabal-installed files."
    export PATH=${PATH}:${HOME}/.cabal/bin
fi

if [[ "${USE_LOCAL_GHC}" != "n" ]]; then
    echo "Using local GHC: ${USE_LOCAL_GHC}"
    export PATH=${PATH}:${HOME}/ghc/${USE_LOCAL_GHC}/bin
fi

# Aliases
alias ls='ls --color=auto -F -h'
alias grep='grep --color=auto'
alias rm='rm -v'
alias vim='vim -p'
alias yum='yum --color=auto'
alias open='gnome-open'

topit() { /usr/bin/top -p `pgrep $1` }
vimfind() { find -name $1 -exec vim -p {} + }

# ghc switching
use_ghc() {
  export PATH=$1/bin:$PATH
}

if [[ $TERM == "dumb" ]] ; then
  alias ls='ls --color=none'
fi

if [[ $TERM == "xterm" ]] ; then
  export TERM="xterm-256color"
fi

# prompt 196
prompt trevor 031 240 196 000 214

# cabal completion
compdef -a _cabal cabal

# use the default dircolors, despite the awesome 256 color palette
eval `dircolors -b /etc/DIR_COLORS`

# load in local config, if available
if [[ -f ~/.zsh/site-config ]]; then
	. ~/.zsh/site-config
fi
