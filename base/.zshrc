# mic_e's .zshrc, version 2014052100
# all globally (on any machine) valid, zsh-specific rc code
# for code shared by bash and zsh, use .sharedrc
# for code local to this machine, use .zshrc_local

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

. ~/.sharedrc

# general shell options
setopt extended_glob longlistjobs completeinword hashlistall bash_rematch
unsetopt autocd beep notify

# command history
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=1000000
setopt append_history share_history extended_history histverify histignorespace

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

# history searching
bindkey "^[[A"          history-beginning-search-backward
bindkey "^[[B"          history-beginning-search-forward

bindkey "^R"            history-incremental-pattern-search-backward
bindkey "^S"            history-incremental-pattern-search-forward

# special keys for several terminals
bindkey '^K'            kill-whole-line
bindkey "\e[1~"         beginning-of-line # Home
bindkey "\e[2~"         quoted-insert # Ins
bindkey "\e[3~"         delete-char # Del
bindkey "\e[4~"         end-of-line # End
bindkey "\e[5~"         beginning-of-history # PageUp
bindkey "\e[6~"         end-of-history # PageDown
bindkey "\e[7~"         beginning-of-line # Home
bindkey "\e[8~"         end-of-line # End
bindkey "\e[5C"         forward-word
bindkey "\e[5D"         backward-word
bindkey "\e\e[C"        forward-word
bindkey "\e\e[D"        backward-word
bindkey "^[[1;5C"       forward-word
bindkey "^[[1;5D"       backward-word
bindkey "\eOc"          emacs-forward-word
bindkey "\eOd"          emacs-backward-word
bindkey "\e[Z"          reverse-menu-complete # Shift+Tab
bindkey "\eOF"          end-of-line
bindkey "\eOH"          beginning-of-line
bindkey "\e[F"          end-of-line
bindkey "\e[H"          beginning-of-line
bindkey "\eOF"          end-of-line
bindkey "\eOH"          beginning-of-line

# command not found handler
# arch
src /usr/share/doc/pkgfile/command-not-found.zsh
# debian
src /etc/zsh_command_not_found

# the prompt
precmd() {
	echo -en '\x07' # bell
	vcs_info
	psvar[1]="$vcs_info_msg_0_"
	psvar[2]="$vcs_info_msg_1_"
}

#       <        exit value         ><user@host>< cwd >< prompt (# or $) >
PROMPT='%b%(0?..%5Ffail: %?%f'$'\n'')%2F%n@%m%f %6F%~%f %B%2F%(!.#.$)%f%b '
#        <   bg jobs  ><  vcs branch   >
RPROMPT='%(1j.%2F[%j].)%(V.%F{%v}%2v%f.)'

# load graphical zshrc
src ~/.zshrc_graphical
# load local zshrc
src ~/.zshrc_local

# vim ft=zsh
