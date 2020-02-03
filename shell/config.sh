# show current directory and time -- experimental (might break multiline edits)
export PS1="[%* %d %n@%m]%% " # zsh

# debian bash
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color|xterm-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='[\D{%T}]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='[\D{%T}]${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*)
  ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
  fi
fi

# Mornings
alias p='prodcertstatus || prodaccess'

# Blaze
alias bb='blaze build'
alias bba='blaze build :all'
alias bbt='blaze test'
alias bbta='blaze test :all'
alias bbr='blaze run'

# Edit this file
alias ebrc='vim ~/.bashrc && . ~/.bashrc'

# Client checking
alias myclients='ls /google/src/cloud/fredyang'
alias hgclients='hg citc --list'

# Languages
alias py3='python3'

# Tools
alias aristotle_cli=/google/data/ro/projects/aristotle/aristotle_cli.par
alias borg_capacity_cli=/google/data/ro/projects/borg-sre/borg_capacity_cli
alias srsly_cli=/google/data/ro/projects/borg-sre/srsly_cli
alias dedicated_labels=/google/data/ro/projects/borg-sre/dedicated_labels.par
alias ipdb_client=/google/data/ro/projects/netops/ipdb_client
alias reachability='/google/bin/releases/cloudnet-modeling/reachability/reachability.par'
alias machine_picker=/google/data/ro/teams/cloud-capacity-automation/machine_picker_v2/live/machine_picker.par
alias siscli.par='/google/data/ro/buildstatic/projects/production/sisyphus/siscli.par'
alias mkredirect='/google/src/head/depot/google3/corp/g3doc_contrib/tools/mkredirect/mkredirect.sh'

# GCP
alias gcp_proj_number='/google/data/ro/teams/oneplatform/namespace_client --project_ids'
alias gcp_proj_name='/google/data/ro/teams/oneplatform/namespace_client --project_numbers'

# Vim
export EDITOR='vim'
set -o vi

PATH=$PATH:/google/data/ro/projects/bandaid/bassh
PATH=$PATH:/google/data/ro/projects/traffic/traffic_cli
PATH=$PATH:/google/data/ro/projects/internetto/etcpdump
PATH=$PATH:/google/data/ro/projects/internetto/ipgoogle
PATH=$PATH:/home/build/google3/production/tools/bsearch/bsearch

# Disable the bell
if [[ $iatest > 0 ]]; then bind "set bell-style visible"; fi

# Expand the history size
export HISTFILESIZE=1000
export HISTSIZE=500

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend

# Allow ctrl-S for history navigation (with ctrl-R)
stty -ixon

# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest > 0 ]]; then bind "set completion-ignore-case on"; fi

# Show auto-completion list automatically, without double tab
if [[ $iatest > 0 ]]; then bind "set show-all-if-ambiguous On"; fi

# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Alias's to modified commands
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -iv'
alias mkdir='mkdir -p'
alias ps='ps auxf'
alias less='less -R'
alias apt-get='sudo apt-get'
alias multitail='multitail --no-repeat -c'
alias vi='vim'
alias svi='sudo vi'

# Remove a directory and all files
alias rmd='rm -rfv '

# Alias's for multiple directory listing commands
alias la='ls -Alh' # show hidden files
alias ls='ls -F' # add colors and file type extensions
alias lx='ls -lXBh' # sort by extension
alias lk='ls -lSrh' # sort by size
alias lc='ls -lcrh' # sort by change time
alias lu='ls -lurh' # sort by access time
alias lr='ls -lRh' # recursive ls
alias lt='ls -ltrh' # sort by date
alias lm='ls -alh |more' # pipe through 'more'
alias lw='ls -xAh' # wide listing format
alias ll='ls -Fls' # long listing format
alias labc='ls -lap' #alphabetical sort
alias lf="ls -l | egrep -v '^d'" # files only
alias ldir="ls -l | egrep '^d'" # directories only

alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# Search files in the current folder
alias f="find . | grep "
# Search files in current folder minus search expression
alias fv="find . | grep -v "

# Alias's to show disk space and space used in a folder
alias diskspace="du -S | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'

# Alias's for archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# Searches for text in all files in the current folder
ftext ()
{
  # -i case-insensitive
  # -I ignore binary files
  # -H causes filename to be printed
  # -r recursive search
  # -n causes line number to be printed
  # optional: -F treat search term as a literal, not a regular expression
  # optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
  grep -iIHrn --color=always "$1" . | less -r
}

# Copy file with a progress bar
cpp()
{
  set -e
  strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
  | awk '{
  count += $NF
  if (count % 10 == 0) {
  percent = count / total_size * 100
  printf "%3d%% [", percent
  for (i=0;i<=percent;i++)
    printf "="
    printf ">"
    for (i=percent;i<100;i++)
    printf " "
    printf "]\r"
    }
  }
  END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

# Copy and go to the directory
cpg ()
{
  if [ -d "$2" ];then
  cp $1 $2 && cd $2
  else
  cp $1 $2
  fi
}

# Move and go to the directory
mvg ()
{
  if [ -d "$2" ];then
  mv $1 $2 && cd $2
  else
  mv $1 $2
  fi
}

# Create and go to the directory
mkdirg ()
{
  mkdir -p $1
  cd $1
}

# Goes up a specified number of directories  (i.e. up 4)
up ()
{
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
  do
    d=$d/..
  done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
  d=..
  fi
  cd $d
}

# Automatically do an ls after each cd
cd ()
{
   if [ -n "$1" ]; then
   builtin cd "$@" && ls
   else
   builtin cd ~ && ls
   fi
}

# Show current network information
netinfo ()
{
  echo "--------------- Network Information ---------------"
  /sbin/ifconfig | awk /'inet addr/ {print $2}'
  echo ""
  /sbin/ifconfig | awk /'Bcast/ {print $3}'
  echo ""
  /sbin/ifconfig | awk /'inet addr/ {print $4}'

  /sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
  echo "---------------------------------------------------"
}

# IP address lookup
alias whatismyip="whatsmyip"
function whatsmyip ()
{
  # Dumps a list of all IP addresses for every device
  # /sbin/ifconfig |grep -B1 "inet addr" |awk '{ if ( $1 == "inet" ) { print $2 } else if ( $2 == "Link" ) { printf "%s:" ,$1 } }' |awk -F: '{ print $1 ": " $3 }';

  # Internal IP Lookup
  echo -n "Internal IP: " ; /sbin/ifconfig eth0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'

  # External IP Lookup
  echo -n "External IP: " ; wget http://smart-ip.net/myip -O - -q
}
