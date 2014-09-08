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
PROMPT_COMMAND='rv=$?; test $rv -gt 0 && echo -e "\x1b[35mfail: $rv\x1b[m"'
if [[ $EUID -eq 0 ]]; then
	PROMPTCHAR='#'
else
	PROMPTCHAR='$'
fi
#    <   user@host   > <        cwd       > <   (bash)   > <          prompt char          >
PS1='\[\e[0;32m\]\u@\h \[\e[36m\]\w\[\e[m\] \[\e[37m\]($0) \[\e[1;32m\]${PROMPTCHAR}\[\e[m\] '

# load graphical bashrc
src ~/.bashrc_graphical

# load local bashrc
src ~/.bashrc_local

# vim ft=sh
