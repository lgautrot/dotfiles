# .zshrc is sourced in interactive shells.  It
# should contain commands to set up aliases, functions,
# options, key bindings, etc.
#

# Search path for the cd command
cdpath=(.. ~ ~/src)

# Use hard limits, except for a smaller stack and no core dumps
unlimit
limit stack 8192
limit core 0
limit -s
umask 002

# Shell functions
setenv() { typeset -x "${1}${1:+=}${(@)argv[2,$#]}" }  # csh compatibility
freload() { while (( $# )); do; unfunction $1; autoload -U $1; shift; done }

# Where to look for autoloaded function definitions
fpath=($fpath ~/.zfunc)

# Autoload all shell functions from all directories in $fpath (following
# symlinks) that have the executable bit on (the executable bit is not
# necessary, but gives you an easy way to stop the autoloading of a
# particular shell function). $fpath should not be empty for this to work.
for func in $^fpath/*(N-.x:t); autoload $func

# automatically remove duplicates from these arrays
typeset -U path cdpath fpath manpath

# Set up aliases
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'       # no spelling correction on cp
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias su='nocorrect su' # no spelling correction on mkdir
alias j=jobs
alias pu=pushd
alias po=popd
alias d='dirs -v'
alias h=history
alias grep=egrep
alias l='ls -l'
alias la='ls -a'
alias ll='ls -l'
alias ls="ls --color=tty"
alias lc="ls --color=no"
alias clr='reset;clear'
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'
alias -g M='|more'
alias -g L='|less'
alias -g H='|head'
alias -g T='|tail'

manpath=($X11HOME/man /usr/man /usr/lang/man /usr/local/man /usr/share/man)
export MANPATH

# Hosts to use for completion
hosts=(`hostname`
`[ -r ~/.ssh/config ] && perl -lane 's/Host\s+//i, print if /^Host\s+/i and not /\*/' ~/.ssh/config`
`getent hosts`)

# Set prompts

case $TERM in
   xterm*)
        precmd () {print -Pn "\e]0;%n@%m: %~\a"}
	PROMPT='%# '
	unset RPROMPT
        ;;
   *)
	PROMPT='[%B%n@%m%b]%# '
	RPROMPT=' %~'
	;;
esac

export PROMPT RPROMPT PS1

# Some environment variables
export MAIL=/var/spool/mail/$USERNAME
export LESS=-rcex3M
export HELPDIR=/usr/local/lib/zsh/help  # directory for run-help function to find docs

MAILCHECK=300
DIRSTACKSIZE=20
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=5000

export HISTSIZE HISTFILE SAVEHIST DIRSTACKSIZE MAILCHECK

# Watch for my friends
#watch=($(cat ~/.friends))      # watch for people in .friends file
watch=(notme)                   # watch for everybody but me
LOGCHECK=300                    # check every 5 min for login/logout activity
WATCHFMT='%n %a %l from %m at %t.'

# Set/unset  shell options
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent noclobber
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
setopt	 NO_BEEP
unsetopt bgnice autoparamslash

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zmodload -ap zsh/mapfile mapfile

# Some nice key bindings
#bindkey '^X^Z' universal-argument ' ' magic-space
#bindkey '^X^A' vi-find-prev-char-skip
#bindkey '^Z' accept-and-hold
#bindkey -s '\M-/' \\\\
#bindkey -s '\M-=' \|

bindkey -v             # vi key bindings

#bindkey -e                 # emacs key bindings
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand

# Setup new style completion system. To see examples of the old style (compctl
# based) programmable completion, check Misc/compctl-examples in the zsh
# distribution.
autoload -U compinit
compinit

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
zstyle '*' hosts $hosts

# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'

#alias fetchall='fetchmail -q ; fetchmail -v ; fetchmail -d 300'

path=($path /sbin/ /usr/sbin/ ~/bin/)

# Set/unset  shell options
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent noclobber
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
setopt    NO_BEEP
unsetopt bgnice autoparamslash

# Set up aliases
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'       # no spelling correction on cp
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias su='nocorrect su' # no spelling correction on mkdir
alias j=jobs
alias pu=pushd
alias po=popd
alias d='dirs -v'
alias h=history
alias grep=egrep
alias cpan="perl -MCPAN -e shell"
alias urxvt=~/bin/urxvt

umask 022

PATH=$PATH:/sbin:/usr/sbin
EDITOR=vim
#LC_PAPER="fr_FR.utf8"
export PATH LD_LIBRARY_PATH EDITOR


autoload zsh-mime-setup
autoload zsh-mime-handler
zsh-mime-setup

source ~/src/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
