
# site-wide settings
if [[ -f /etc/zshrc ]]; then
  . /etc/zshrc
fi

OS=`uname`

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

# Aliases
if [[ $OS == "Darwin" ]]; then
  alias ls='ls -G -F -h'
else
  alias ls='ls --color=auto -F -h'
fi
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
else
  # colored tab-completion
  zstyle -e ':completion:*:default' list-colors 'reply=("${(@s.:.)LS_COLORS}")'
fi

if [[ $TERM == "xterm" ]] ; then
  export TERM="xterm-256color"
fi

# prompt
prompt trevor 014 blue red default yellow

# cabal completion
compdef -a _cabal cabal

# use the default dircolors, despite the awesome 256 color palette
if [[ $OS == "Linux" ]]; then
  eval `dircolors -b /etc/DIR_COLORS`
fi

# load in local config, if available
if [[ -f ~/.zsh/site-config ]]; then
  . ~/.zsh/site-config
fi
