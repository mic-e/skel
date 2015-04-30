# mic_e's .zshrc, version 2014052100
# all globally (on any machine) valid, zsh-specific rc code
# for code shared by bash and zsh, use .sharedrc
# for code local to this machine, use .zshrc_local

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.sharedrc

# general shell options
setopt extended_glob longlistjobs completeinword hashlistall bash_rematch
unsetopt autocd beep notify nomatch

# command history
if [[ $INCOGNITO -gt 0 ]]; then
	INCOGNITOPROMPT="%B%7F[I] %f%b"
else
	HISTFILE=~/.zsh_history
	HISTSIZE=100000
	SAVEHIST=1000000
	setopt append_history share_history extended_history histverify histignorespace
	INCOGNITOPROMPT=""
fi

# directory history
setopt autopushd pushdminus pushdsilent pushdtohome

# don't record these to history
alias git status=" git status"

# autocompletion (global)
zstyle ":completion:*" auto-description "%d"
zstyle ":completion:*" completer _expand _complete _ignored
zstyle ":completion:*" completions 1
zstyle ":completion:*" expand prefix suffix
zstyle ":completion:*" file-sort modification
zstyle ":completion:*" format '%{[1;31m%}%d%{[m%}'
zstyle ":completion:*" glob 1
zstyle ":completion:*" group-name ''
zstyle ":completion:*" insert-unambiguous true
zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}
zstyle ":completion:*" list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ":completion:*" list-suffixes true
zstyle ":completion:*" matcher-list '' '' '' ''
zstyle ":completion:*" menu select=1
zstyle ":completion:*" original true
zstyle ":completion:*" preserve-prefix '//[^/]# #/'
zstyle ":completion:*" select-prompt %SScrolling active: current selection at %p%s
zstyle ":completion:*" squeeze-slashes true
zstyle ":completion:*" substitute 1
zstyle ":completion:*" verbose true
zstyle ":compinstall" filename ~/.zshrc

autoload -Uz compinit
compinit

# manpage completion
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true
zstyle ':completion:*:man:*'      menu yes select

# process completion
zstyle ':completion:*:processes'  command 'ps -au$USER'
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

# url completion
zstyle ':completion:*:urls' local 'www' '/var/www/' 'public_html'

# host completion, stolen from grml config
test -r ~/.ssh/known_hosts && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:# [\|]*}%%\ *}%%,*}) || _ssh_hosts=()
test -r /etc/hosts && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\# *}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()
hosts=(
	$(hostname)
	"$_ssh_hosts[@]"
	"$_etc_hosts[@]"
	8.8.8.8
	2001:4860:4860::8888
	google.com
	127.0.0.1
	::1
	localhost
)
zstyle ':completion:*:hosts' hosts $hosts

# define completion styles for own commands
compdef run_disowned=command
compdef dos=command

# vcs info
autoload -Uz vcs_info
zstyle ':vcs_info:*'            enable git svn hg
zstyle ':vcs_info:*'            max-exports 3

zstyle ':vcs_info:*'            formats           7 "[%s:%b]"
zstyle ':vcs_info:*'            actionformats     7 "[%a %s:%b]"

zstyle ':vcs_info:git:*'        formats         208 "[%b]"
zstyle ':vcs_info:git:*'        actionformats   208 "[%a %b]"

# key bindings: emacs style
bindkey -e

# retrieve key info from terminfo
typeset -A keys
keys[Home]=${terminfo[khome]}
keys[End]=${terminfo[kend]}
keys[Insert]=${terminfo[kich1]}
keys[Delete]=${terminfo[kdch1]}
keys[Up]=${terminfo[kcuu1]}
keys[Down]=${terminfo[kcud1]}
keys[Left]=${terminfo[kcub1]}
keys[Right]=${terminfo[kcuf1]}
keys[ShiftLeft]=${terminfo[kLFT]}
keys[ShiftRight]=${terminfo[kRIT]}
keys[PageUp]=${terminfo[kpp]}
keys[PageDown]=${terminfo[knp]}
keys[ShiftTab]=${terminfo[kcbt]}

function trybindkey() {
	key="$1"
	binding="$2"

	keyval="${keys[$key]}"
	if [ -n "${keyval}" ]; then
		bindkey "${keyval}" "${binding}"
	fi
}

# key bindings
trybindkey Home       beginning-of-line
trybindkey End        end-of-line
trybindkey Insert     quoted-insert
trybindkey Delete     delete-char
trybindkey Up         history-beginning-search-backward
trybindkey Down       history-beginning-search-forward
trybindkey Left       backward-char
trybindkey Right      forward-char
trybindkey ShiftLeft  backward-word
trybindkey ShiftRight forward-word
trybindkey PageUp     beginning-of-history
trybindkey PageDown   end-of-history
trybindkey ShiftTab   reverse-menu-complete

# emacs-y bindings
bindkey "^R"                  history-incremental-pattern-search-backward
bindkey "^S"                  history-incremental-pattern-search-forward
bindkey '^K'                  kill-whole-line

# command not found handler
# arch
src /usr/share/doc/pkgfile/command-not-found.zsh
# debian
src /etc/zsh_command_not_found

# the prompt
precmd() {
	# echo -en '\x07' # bell
	vcs_info
	psvar[1]="$vcs_info_msg_0_"
	psvar[2]="$vcs_info_msg_1_"
}

#       <        exit value         ><user@host>                    < cwd >< prompt (# or $) >
PROMPT='%b%(0?..%5Ffail: %?%f'$'\n'')%2F%n@%m%f '"$INCOGNITOPROMPT"'%6F%~%f %B%2F%(!.#.$)%f%b '
#        <   bg jobs  ><  vcs branch   >
RPROMPT='%(1j.%2F[%j].)%(V.%F{%v}%2v%f.)'

# load graphical zshrc
src ~/.zshrc_graphical
# load local zshrc
src ~/.zshrc_local

# vim ft=zsh
