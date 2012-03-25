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
autoload -U compinit colors promptinit
compinit
colors
promptinit

export EDITOR=vim

# Path
export PATH=/usr/java/default/bin:$PATH
export PATH=$HOME/.cabal/bin:$PATH

# Aliases
alias ls='ls --color=auto -F -h'
alias grep='grep --color=auto'
alias rm='rm -v'
alias vim='vim -p'
alias yum='yum --color=auto'

topit() { /usr/bin/top -p `pgrep $1` }
vimfind() { find -name $1 -exec vim -p {} + }

# ghc switching
use_ghc() {
  export PATH=$1/bin:$PATH
}

use_ghc $HOME/ghc/7.4.1

if [[ $TERM == "dumb" ]] ; then
  alias ls='ls --color=none'
fi

if [[ $TERM == "xterm" ]] ; then
  export TERM="xterm-256color"
fi

# prompt
prompt trevor cyan blue red default yellow

# cabal completion
compdef -a _cabal cabal

# use the default dircolors, despite the awesome 256 color palette
eval `dircolors -b /etc/DIR_COLORS`

# load in local config, if available
if [[ -f ~/zsh/site-config ]]; then
	. ~/zsh/site-config
fi
