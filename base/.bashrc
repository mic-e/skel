# mic_e's .bashrc, version 2014052100
# all globally (on any machine) valid, bash-specific rc code
# for code shared by bash and zsh, use .sharedrc
# for code local to this machine, use .bashrc_local

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.sharedrc

#general shell options
shopt -s histverify extglob histappend

# emulate zsh's noglob
function noglob() {
	command $@
	set +f
}
alias noglob='set -f;noglob'

# emulate zsh's history (don't log anything starting with ' ')
HISTIGNORE=" *"

# command not found handler
# arch
src /usr/share/doc/pkgfile/command-not-found.bash
# debian
src /etc/bash_command_not_found

# the prompt
PROMPT_COMMAND='PROMPT_COL="`eval $PROMPTCOLOR_COMMAND`"'
if [[ $EUID -eq 0 ]]; then
	PS1='\[\e[1;31m\]\u@\h \[\e[36m\]\w\[\e[m\] \[\e[37m\]($0) \[\e[${PROMPT_COL}\]#\[\e[m\] '
else
	PS1='\[\e[0;32m\]\u@\h \[\e[36m\]\w\[\e[m\] \[\e[37m\]($0) \[\e[${PROMPT_COL}\]\$\[\e[m\] '
fi

# load graphical bashrc
src ~/.bashrc_graphical

# load local bashrc
src ~/.bashrc_local

# vim ft=sh
