#! /usr/bin/env zsh

bindkey -v

stty sane
#stty erase 

if [[ $OSTYPE == darwin* ]]; then
   TERM=xterm-color
   export SSH_AUTH_SOCK=/tmp/tiago-sshagent/SSHAuthSock
   if [ ! -d /tmp/tiago-sshagent ]
   then
      mkdir /tmp/tiago-sshagent
      chmod 700 /tmp/tiago-sshagent
   fi
   if [ ! -S $SSH_AUTH_SOCK ]
   then
      ssh-agent -a $SSH_AUTH_SOCK
      ssh-add
   fi
elif [[ $OSTYPE == solaris* ]]; then TERM=dtterm
elif [[ $OSTYPE == cygwin* ]]; then TERM=cygwin
else TERM=vt100
fi
export TERM

if [[ $OSTYPE == solaris* ]]; then
   path=(
      /usr/sbin /usr/bin /usr/ccs/bin /usr/openwin/bin /usr/dt/bin
      /usr/platform/SUNW,Ultra-60/sbin /usr/cluster/bin /usr/cluster/lib/sc
      /opt/SUNWexplo/bin /usr/local/bin /usr/local/samba/bin
   )
fi
path=($path /opt/local/bin/ .)
cdpath=($cdpath .)
manpath=($manpath .)
export path cdpath manpath

HISTSIZE=1000
HISTFILE=$HOME/.zsh_history
SAVEHIST=1000

export LESS="--quit-at-eof --ignore-case --LONG-PROMPT --RAW-CONTROL-CHARS --squeeze-blank-lines"
export PAGER=less

function sscreen {
    ssh -t "${1}" /usr/bin/screen -xRR
}

## set zsh prompt

#--------------------------------------------
# Color constants used in the prompt
#--------------------------------------------
BLACK="%{[0m%}"
BOLD_BLACK="%{[1;30m%}"
RED="%{[0;31m%}"
BOLD_RED="%{[1;31m%}"
GREEN="%{[0;32m%}"
BOLD_GREEN="%{[1;32m%}"
YELLOW="%{[0;33m%}"
BOLD_YELLOW="%{[1;33m%}"
BLUE="%{[0;34m%}"
BOLD_BLUE="%{[1;34m%}"
MAUVE="%{[0;35m%}"
BOLD_MAUVE="%{[1;35m%}"
CYAN="%{[0;36m%}"
BOLD_CYAN="%{[1;36m%}"
WHITE="%{[0;37m%}"
DEFAULT="%{[0;39m%}"

if [[ $OSTYPE != solaris* ]]; then
	autoload -U colors
	colors
fi

PS1="%S%! %D{%Y-%m-%d} %*%s ${GREEN}%n${BLACK}@${BLUE}%m ${CYAN}lvl:%L err:%?
${BOLD_MAUVE}%~
${BOLD_RED}%# ${BLACK}"

export PS1

## set zsh aliases

if [[ $OSTYPE == darwin* ]]; then alias lc='ls -G'
elif [[ $OSTYPE == solaris* ]]; then
	if [[ -x /usr/local/bin/ls ]]; then alias lc='/usr/local/bin/ls --color'
	else alias lc=ls
	fi
elif [[ $OSTYPE == cygwin ]]; then alias lc='ls --color'
else alias lc=ls
fi

alias flep='pgrep -fl'
alias lsa='ls -AFlh'
alias lsd='ls -AFldh'
alias l='lc -F'
alias ld='l -d'
alias la='l -A'
alias ll='l -l'
alias lla='ll -A'
alias llt='ll -rt'
alias lt='l -rt'
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'
alias df='df -h'
alias du='du -h'
alias more=less
alias timestamp='date "+%Y-%m-%d_%H:%M:%S"'
alias d='dirs -v'
alias h='fc -li'

## set zsh options

#Changing Directories
setopt auto_cd
#    AUTO_CD (-J) (unset)
#           If a command is issued that can't be executed as a  normal  com-
#           mand, and the command is the name of a directory, perform the cd
#           command to that directory.
setopt auto_pushd
#    AUTO_PUSHD (-N) (unset)
#           Make cd push the old directory onto the directory stack.
setopt cdable_vars
#    CDABLE_VARS (-T) (unset)
#           If the argument to a cd command  (or  an  implied  cd  with  the
#           AUTO_CD  option set) is not a directory, and does not begin with
#           a slash, try to expand the expression as if it were preceded  by
#           a `~' (see the section `Filename Expansion').
#    CHASE_DOTS (unset)
#           When  changing  to  a  directory  containing a path segment `..'
#           which would otherwise be treated as canceling the previous  seg-
#           ment in the path (in other words, `foo/..' would be removed from
#           the path, or if `..' is the first part of  the  path,  the  last
#           part  of $PWD would be deleted), instead resolve the path to the
#           physical directory.  This option is overridden by CHASE_LINKS.
#
#           For example,  suppose  /foo/bar  is  a  link  to  the  directory
#           /alt/rod.   Without this option set, `cd /foo/bar/..' changes to
#           /foo; with it set, it changes to /alt.  The same applies if  the
#           current  directory  is  /foo/bar and `cd ..' is used.  Note that
#           all other symbolic links in the path will also be resolved.
#    CHASE_LINKS (-w) (unset)
#           Resolve symbolic links to their true values when changing direc-
#           tory.   This also has the effect of CHASE_DOTS, i.e. a `..' path
#           segment will be treated as referring  to  the  physical  parent,
#           even if the preceding path segment is a symbolic link.
setopt pushd_ignore_dups
#    PUSHD_IGNORE_DUPS (unset)
#           Don't push multiple copies of the same directory onto the direc-
#           tory stack.
setopt pushd_minus
#    PUSHD_MINUS (unset)
#           Exchanges the meanings of `+' and `-' when used with a number to
#           specify a directory in the stack.
#    PUSHD_SILENT (-E) (unset)
#           Do not print the directory stack after pushd or popd.
#    PUSHD_TO_HOME (-D) (unset)
#           Have pushd with no arguments act like `pushd $HOME'.
#Completion
#    ALWAYS_LAST_PROMPT <D> (set - NO_ALWAYS_LAST_PROMPT unset)
#           If  unset,  key functions that list completions try to return to
#           the last prompt if given a numeric argument. If set these  func-
#           tions try to return to the last prompt if given no numeric argu-
#           ment.
#    ALWAYS_TO_END (unset)
#           If a completion is performed with the cursor within a word,  and
#           a full completion is inserted, the cursor is moved to the end of
#           the word.  That is, the cursor is moved to the end of  the  word
#           if  either a single match is inserted or menu completion is per-
#           formed.
setopt auto_list # (unset by default in solaris)
#    AUTO_LIST (-9) <D> (set - NO_AUTO_LIST unset)
#           Automatically list choices on an ambiguous completion.
setopt auto_menu # (unset by default in solaris)
#    AUTO_MENU <D> (set - NO_AUTO_MENU unset)
#           Automatically use menu completion after the  second  consecutive
#           request  for  completion,  for  example  by pressing the tab key
#           repeatedly. This option is overridden by MENU_COMPLETE.
#    AUTO_NAME_DIRS (unset)
#           Any parameter that is set to the absolute name  of  a  directory
#           immediately becomes a name for that directory, that will be used
#           by the `%~' and related prompt sequences, and will be  available
#           when completion is performed on a word starting with `~'.  (Oth-
#           erwise, the parameter must be used in the form `~param'  first.)
#    AUTO_PARAM_KEYS <D> (set - NO_AUTO_PARAM_KEYS unset)
#           If  a  parameter  name  was  completed and a following character
#           (normally a space) automatically inserted, and the next  charac-
#           ter  typed  is one of those that have to come directly after the
#           name (like `}', `:', etc.), the automatically added character is
#           deleted, so that the character typed comes immediately after the
#           parameter name.  Completion in a  brace  expansion  is  affected
#           similarly:  the  added character is a `,', which will be removed
#           if `}' is typed next.
#    AUTO_PARAM_SLASH <D> (set - NO_AUTO_PARAM_SLASH unset)
#           If a parameter is completed whose  content  is  the  name  of  a
#           directory, then add a trailing slash instead of a space.
#    AUTO_REMOVE_SLASH <D> (set - NO_AUTO_REMOVE_SLASH unset)
#           When  the  last character resulting from a completion is a slash
#           and the next character typed is a word delimiter, a slash, or  a
#           character  that ends a command (such as a semicolon or an amper-
#           sand), remove the slash.
#    BASH_AUTO_LIST (unset)
#           On an ambiguous completion, automatically list choices when  the
#           completion  function  is called twice in succession.  This takes
#           precedence over AUTO_LIST.  The  setting  of  LIST_AMBIGUOUS  is
#           respected.   If  AUTO_MENU  is set, the menu behaviour will then
#           start with the third press.  Note that this will not  work  with
#           MENU_COMPLETE, since repeated completion calls immediately cycle
#           through the list in that case.
#    COMPLETE_ALIASES (unset)
#           Prevents aliases on the command line from being internally  sub-
#           stituted  before completion is attempted.  The effect is to make
#           the alias a distinct command for completion purposes.
setopt complete_in_word
#    COMPLETE_IN_WORD (unset)
#           If unset, the cursor is set to the end of the word if completion
#           is started. Otherwise it stays there and completion is done from
#           both ends.
setopt glob_complete
#    GLOB_COMPLETE (unset)
#           When the current word has a glob pattern, do not insert all  the
#           words  resulting  from the expansion but generate matches as for
#           completion  and  cycle  through  them  like  MENU_COMPLETE.  The
#           matches  are  generated  as if a `*' was added to the end of the
#           word, or inserted at the cursor when  COMPLETE_IN_WORD  is  set.
#           This  actually  uses pattern matching, not globbing, so it works
#           not only for files but for any completion, such as options, user
#           names, etc.
#
#           Note  that  when  the  pattern matcher is used, matching control
#           (for example, case-insensitive or anchored matching)  cannot  be
#           used.   This  limitation only applies when the current word con-
#           tains a pattern; simply turning on the GLOB_COMPLETE option does
#           not have this effect.
#    HASH_LIST_ALL <D> (set - NO_HASH_LIST_ALL unset)
#           Whenever a command completion is attempted, make sure the entire
#           command path is hashed first.  This makes the  first  completion
#           slower.
#    LIST_AMBIGUOUS <D> (set - NO_LIST_AMBIGUOUS unset)
#           This  option works when AUTO_LIST or BASH_AUTO_LIST is also set.
#           If there is an unambiguous prefix to insert on the command line,
#           that is done without a completion list being displayed; in other
#           words, auto-listing behaviour  only  takes  place  when  nothing
#           would  be  inserted.   In the case of BASH_AUTO_LIST, this means
#           that the list will be delayed to the third call of the function.
setopt no_list_beep
#    LIST_BEEP <D> (set - NO_LIST_BEEP unset)
#           Beep  on  an ambiguous completion.  More accurately, this forces
#           the completion widgets to return status 1 on an  ambiguous  com-
#           pletion,  which  causes  the shell to beep if the option BEEP is
#           also set; this may be modified if completion is  called  from  a
#           user-defined widget.
#    LIST_PACKED (unset)
#           Try  to  make the completion list smaller (occupying less lines)
#           by printing the matches in columns with different widths.
#    LIST_ROWS_FIRST (unset)
#           Lay out the matches in  completion  lists  sorted  horizontally,
#           that  is, the second match is to the right of the first one, not
#           under it as usual.
#    LIST_TYPES (-X) <D> (set - NO_LIST_TYPES unset)
#           When listing files that are possible completions, show the  type
#           of each file with a trailing identifying mark.
#    MENU_COMPLETE (-Y) (unset)
#           On  an ambiguous completion, instead of listing possibilities or
#           beeping, insert the first match immediately.  Then when  comple-
#           tion  is  requested again, remove the first match and insert the
#           second match, etc.  When there are no more matches, go  back  to
#           the  first one again.  reverse-menu-complete may be used to loop
#           through the list in the other direction. This  option  overrides
#           AUTO_MENU.
#    REC_EXACT (-S) (unset)
#           In  completion, recognize exact matches even if they are ambigu-
#           ous.
#
#Expansion and Globbing
#    BAD_PATTERN (+2) <C> <Z> (set - NO_BAD_PATTERN unset)
#           If a pattern for filename generation is badly formed,  print  an
#           error  message.   (If  this option is unset, the pattern will be
#           left unchanged.)
#    BARE_GLOB_QUAL <Z> (set - NO_BARE_GLOB_QUAL unset)
#           In a glob pattern, treat a trailing  set  of  parentheses  as  a
#           qualifier  list,  if it contains no `|', `(' or (if special) `~'
#           characters.  See the section `Filename Generation'.
#    BRACE_CCL (unset)
#           Expand expressions in braces which would not  otherwise  undergo
#           brace  expansion  to a lexically ordered list of all the charac-
#           ters.  See the section `Brace Expansion'.
#    CASE_GLOB <D> (set - NO_CASE_GLOB unset)
#           Make globbing (filename generation)  sensitive  to  case.   Note
#           that  other  uses  of patterns are always sensitive to case.  If
#           the option is unset, the presence of any character which is spe-
#           cial  to  filename generation will cause case-insensitive match-
#           ing.  For example, cvs(/) can match the directory CVS  owing  to
#           the   presence   of   the   globbing  flag  (unless  the  option
#           BARE_GLOB_QUAL is unset).
#    CSH_NULL_GLOB <C> (unset)
#           If a pattern for filename generation has no matches, delete  the
#           pattern  from  the  argument list; do not report an error unless
#           all the patterns  in  a  command  have  no  matches.   Overrides
#           NOMATCH.
#    EQUALS <Z> (set - NO_EQUALS unset)
#           Perform = filename expansion.  (See the section `Filename Expan-
#           sion'.)
setopt extended_glob
#    EXTENDED_GLOB (unset)
#           Treat the `#', `~' and `^' characters as part  of  patterns  for
#           filename  generation, etc.  (An initial unquoted `~' always pro-
#           duces named directory expansion.)
#    GLOB (+F, ksh: +f) <D> (set - NO_GLOB unset)
#           Perform filename generation (globbing).  (See the section `File-
#           name Generation'.)
#    GLOB_ASSIGN <C> (unset)
#           If  this  option  is set, filename generation (globbing) is per-
#           formed on the right hand side of scalar parameter assignments of
#           the  form  `name=pattern (e.g. `foo=*').  If the result has more
#           than one word the parameter will  become  an  array  with  those
#           words  as  arguments. This option is provided for backwards com-
#           patibility only: globbing is always performed on the right  hand
#           side  of  array  assignments  of  the  form `name=(value)' (e.g.
#           `foo=(*)') and this form is recommended for clarity;  with  this
#           option  set,  it  is  not possible to predict whether the result
#           will be an array or a scalar.
#setopt glob_dots
#    GLOB_DOTS (-4) (unset)
#           Do not require a leading `.' in a filename to be matched explic-
#           itly.
#    GLOB_SUBST <C> <K> <S> (unset)
#           Treat any characters resulting from parameter expansion as being
#           eligible for file expansion and  filename  generation,  and  any
#           characters resulting from command substitution as being eligible
#           for filename generation.  Braces (and commas in between) do  not
#           become eligible for expansion.
#    IGNORE_BRACES (-I) <S> (unset)
#           Do not perform brace expansion.
#    KSH_GLOB <K> (unset)
#           In  pattern  matching,  the  interpretation  of  parentheses  is
#           affected by a preceding `@', `*', `+', `?' or `!'.  See the sec-
#           tion `Filename Generation'.
#    MAGIC_EQUAL_SUBST (unset)
#           All unquoted arguments of the form `anything=expression' appear-
#           ing after the command name have  filename  expansion  (that  is,
#           where  expression has a leading `~' or `=') performed on expres-
#           sion as if it were a parameter assignment.  The argument is  not
#           otherwise  treated  specially;  it is passed to the command as a
#           single argument, and not used as an actual parameter assignment.
#           For  example,  in  echo  foo=~/bar:~/rod,  both occurrences of ~
#           would be replaced.  Note that this happens anyway  with  typeset
#           and similar statements.
#
#           This  option respects the setting of the KSH_TYPESET option.  In
#           other words, if both options are in  effect,  arguments  looking
#           like assignments will not undergo wordsplitting.
setopt mark_dirs
#    MARK_DIRS (-8, ksh: -X) (unset)
#           Append  a  trailing  `/'  to  all directory names resulting from
#           filename generation (globbing).
#    NOMATCH (+3) <C> <Z> (set - NO_NOMATCH unset)
#           If a pattern for filename generation has no  matches,  print  an
#           error,  instead  of  leaving  it unchanged in the argument list.
#           This also applies to file expansion of an initial `~' or `='.
#    NULL_GLOB (-G) (unset)
#           If a pattern for filename generation has no matches, delete  the
#           pattern  from  the  argument list instead of reporting an error.
#           Overrides NOMATCH.
#    NUMERIC_GLOB_SORT (unset)
#           If numeric filenames are matched by a filename  generation  pat-
#           tern,  sort  the filenames numerically rather than lexicographi-
#           cally.
setopt rc_expand_param
#    RC_EXPAND_PARAM (-P) (unset)
#           Array expansions of the form `foo${xx}bar', where the  parameter
#           xx  is  set  to  (a  b c), are substituted with `fooabar foobbar
#           foocbar' instead of the default `fooa b cbar'.
#    SH_GLOB <K> <S> (unset)
#           Disables the special meaning of `(', `|', `)' and '<' for  glob-
#           bing  the  result of parameter and command substitutions, and in
#           some other places where the shell accepts patterns.  This option
#           is set by default if zsh is invoked as sh or ksh.
#    UNSET (+u, ksh: +u) <K> <S> <Z> (set - NO_SHORT_LOOPS unset)
#           Treat  unset parameters as if they were empty when substituting.
#           Otherwise they are treated as an error.
#
#History
#    APPEND_HISTORY <D> (set - NO_APPEND_HISTORY unset)
#           If this is set, zsh sessions will append their history  list  to
#           the  history file, rather than overwrite it. Thus, multiple par-
#           allel zsh sessions will all have their history  lists  added  to
#           the history file, in the order they are killed.
#    BANG_HIST (+K) <C> <Z> (set - NO_BANG_HIST unset)
#           Perform textual history expansion, csh-style, treating the char-
#           acter `!' specially.
setopt extended_history
#    EXTENDED_HISTORY <C> (unset)
#           Save each command's beginning timestamp (in  seconds  since  the
#           epoch)  and  the duration (in seconds) to the history file.  The
#           format of this prefixed data is:
#
#           `:<beginning time>:<elapsed seconds>:<command>'.
#    HIST_ALLOW_CLOBBER (unset)
#           Add `|' to output redirections in the history.  This allows his-
#           tory references to clobber files even when CLOBBER is unset.
#    HIST_BEEP <D> (set - NO_HIST_BEEP unset)
#           Beep  when  an  attempt  is made to access a history entry which
#           isn't there.
#    HIST_EXPIRE_DUPS_FIRST (unset)
#           If the internal history needs to be trimmed to add  the  current
#           command  line, setting this option will cause the oldest history
#           event that has a duplicate to be lost  before  losing  a  unique
#           event  from  the  list.   You should be sure to set the value of
#           HISTSIZE to a larger number than SAVEHIST in order to  give  you
#           some  room for the duplicated events, otherwise this option will
#           behave just like HIST_IGNORE_ALL_DUPS once the history fills  up
#           with unique events.
#    HIST_FIND_NO_DUPS (unset)
#           When  searching  for  history entries in the line editor, do not
#           display duplicates of a  line  previously  found,  even  if  the
#           duplicates are not contiguous.
#    HIST_IGNORE_ALL_DUPS (unset)
#           If a new command line being added to the history list duplicates
#           an older one, the older command is removed from the  list  (even
#           if it is not the previous event).
setopt hist_ignore_dups
#    HIST_IGNORE_DUPS (-h) (unset)
#           Do  not  enter  command  lines into the history list if they are
#           duplicates of the previous event.
#    HIST_IGNORE_SPACE (-g) (unset)
#           Remove command lines from the history list when the first  char-
#           acter  on  the  line  is  a  space,  or when one of the expanded
#           aliases contains a leading space.  Note that the command lingers
#           in the internal history until the next command is entered before
#           it vanishes, allowing you to briefly reuse or edit the line.  If
#           you  want  to make it vanish right away without entering another
#           command, type a space and press return.
#    HIST_NO_FUNCTIONS (unset)
#           Remove function definitions from the history  list.   Note  that
#           the function lingers in the internal history until the next com-
#           mand is entered before it vanishes, allowing you to briefly  re-
#           use or edit the definition.
setopt hist_no_store
#    HIST_NO_STORE (unset)
#           Remove  the  history  (fc -l) command from the history list when
#           invoked.  Note that the command lingers in the internal  history
#           until  the  next command is entered before it vanishes, allowing
#           you to briefly reuse or edit the line.
setopt hist_reduce_blanks
#    HIST_REDUCE_BLANKS (unset)
#           Remove superfluous blanks from each command line being added  to
#           the history list.
#    HIST_SAVE_NO_DUPS (unset)
#           When writing out the history file, older commands that duplicate
#           newer ones are omitted.
setopt hist_verify
#    HIST_VERIFY (unset)
#           Whenever the user enters a line with  history  expansion,  don't
#           execute  the  line  directly; instead, perform history expansion
#           and reload the line into the editing buffer.
#    INC_APPEND_HISTORY (unset)
#           This options works like APPEND_HISTORY except that  new  history
#           lines  are added to the $HISTFILE incrementally (as soon as they
#           are entered), rather than waiting until  the  shell  is  killed.
#           The  file  is periodically trimmed to the number of lines speci-
#           fied by $SAVEHIST, but can exceed this value between  trimmings.
if [[ $OSTYPE != solaris* ]]; then
	setopt share_history
fi
#    SHARE_HISTORY <K> (unset)
#           This option both imports new commands from the history file, and
#           also causes your typed commands to be appended  to  the  history
#           file  (the  latter  is like specifying INC_APPEND_HISTORY).  The
#           history lines are also output with timestamps ala  EXTENDED_HIS-
#           TORY  (which  makes it easier to find the spot where we left off
#           reading the file after it gets re-written).
#
#           By default, history movement commands visit the  imported  lines
#           as  well  as the local lines, but you can toggle this on and off
#           with the set-local-history zle binding.  It is also possible  to
#           create a zle widget that will make some commands ignore imported
#           commands, and some include them.
#
#           If you find that you want more control over  when  commands  get
#           imported,    you   may   wish   to   turn   SHARE_HISTORY   off,
#           INC_APPEND_HISTORY on, and then manually import  commands  when-
#           ever you need them using `fc -RI'.
#
#Initialisation
#    ALL_EXPORT (-a, ksh: -a) (unset)
#           All  parameters subsequently defined are automatically exported.
#    GLOBAL_EXPORT (<Z>) (set - NO_GLOBAL_EXPORT unset)
#           If this option is set, passing  the  -x  flag  to  the  builtins
#           declare,  float,  integer,  readonly and typeset (but not local)
#           will also set the -g flag;  hence  parameters  exported  to  the
#           environment  will  not  be made local to the enclosing function,
#           unless they were already or the flag +g is given explicitly.  If
#           the  option  is unset, exported parameters will be made local in
#           just the same way as any other parameter.
#
#           This option is set by default for backward compatibility; it  is
#           not  recommended  that  its behaviour be relied upon.  Note that
#           the builtin export always sets both the -x  and  -g  flags,  and
#           hence its effect extends beyond the scope of the enclosing func-
#           tion; this is the most portable way to achieve this behaviour.
#    GLOBAL_RCS (-d) <D> (set - NO_GLOBAL_RCS unset)
#           If this  option  is  unset,  the  startup  files  /etc/zprofile,
#           /etc/zshrc,  /etc/zlogin  and  /etc/zlogout will not be run.  It
#           can be disabled and re-enabled at  any  time,  including  inside
#           local startup files (.zshrc, etc.).
#    RCS (+f) <D> (set - NO_RCS unset)
#           After  /etc/zshenv  is  sourced  on startup, source the .zshenv,
#           /etc/zprofile, .zprofile, /etc/zshrc, .zshrc, /etc/zlogin, .zlo-
#           gin,  and  .zlogout  files, as described in the section `Files'.
#           If this option is unset, the /etc/zshenv file is still  sourced,
#           but  any of the others will not be; it can be set at any time to
#           prevent the remaining startup files after the currently  execut-
#           ing one from being sourced.
#
#Input/Output
#    ALIASES <D> (set - NO_ALIASES unset)
#           Expand aliases.
#    CLOBBER (+C, ksh: +C) <D> (set - NO_CLOBBER unset)
#           Allows  `>'  redirection to truncate existing files, and `>>' to
#           create files.  Otherwise `>!' or `>|' must be used to truncate a
#           file, and `>>!' or `>>|' to create a file.
#    CORRECT (-0) (unset)
#           Try  to  correct  the spelling of commands.  Note that, when the
#           HASH_LIST_ALL option is not set or when some directories in  the
#           path  are  not readable, this may falsely report spelling errors
#           the first time some commands are used.
#    CORRECT_ALL (-O) (unset)
#           Try to correct the spelling of all arguments in a line.
#    DVORAK (unset)
#           Use the Dvorak keyboard instead of the standard qwerty  keyboard
#           as  a  basis for examining spelling mistakes for the CORRECT and
#           CORRECT_ALL options and the spell-word editor command.
#    FLOW_CONTROL <D> (set - NO_FLOW_CONTROL unset)
#           If this option is unset,  output  flow  control  via  start/stop
#           characters  (usually  assigned  to  ^S/^Q)  is  disabled  in the
#           shell's editor.
#    IGNORE_EOF (-7) (unset)
#           Do not exit on end-of-file.  Require the use of exit  or  logout
#           instead.   However, ten consecutive EOFs will cause the shell to
#           exit anyway, to avoid the shell hanging if its tty goes away.
#
#           Also, if this option is set and the Zsh  Line  Editor  is  used,
#           widgets implemented by shell functions can be bound to EOF (nor-
#           mally Control-D) without printing the  normal  warning  message.
#           This  works only for normal widgets, not for completion widgets.
#    INTERACTIVE_COMMENTS (-k) <K> <S> (unset)
#           Allow comments even in interactive shells.
#    HASH_CMDS <D> (set - NO_HASH_CMDS unset)
#           Note the location of each command the first time it is executed.
#           Subsequent  invocations  of  the same command will use the saved
#           location, avoiding a path search.  If this option is  unset,  no
#           path hashing is done at all.  However, when CORRECT is set, com-
#           mands whose names do not appear in the functions or aliases hash
#           tables  are  hashed in order to avoid reporting them as spelling
#           errors.
#    HASH_DIRS <D> (set - NO_HASH_DIRS unset)
#           Whenever a command name is hashed, hash the directory containing
#           it,  as  well as all directories that occur earlier in the path.
#           Has no effect if neither HASH_CMDS nor CORRECT is set.
#    MAIL_WARNING (-U) (unset)
#           Print a warning message if a mail file has been  accessed  since
#           the shell last checked.
setopt path_dirs
#    PATH_DIRS (-Q) (unset)
#           Perform  a  path  search  even  on command names with slashes in
#           them.  Thus if `/usr/local/bin' is in the user's path, and he or
#           she  types  `X11/xinit',  the command `/usr/local/bin/X11/xinit'
#           will be executed  (assuming  it  exists).   Commands  explicitly
#           beginning  with  `/',  `./' or `../' are not subject to the path
#           search.  This also applies to the . builtin.
#
#           Note that subdirectories of the  current  directory  are  always
#           searched  for  executables  specified  in this form.  This takes
#           place before any search indicated by this option, and regardless
#           of  whether  `.'  or the current directory appear in the command
#           search path.
#    PRINT_EIGHT_BIT (unset)
#           Print eight bit characters literally in completion  lists,  etc.
#           This  option  is  not necessary if your system correctly returns
#           the printability of eight bit characters (see ctype(3)).
#    PRINT_EXIT_VALUE (-1) (unset)
#           Print the exit value of programs with non-zero exit status.
#    RC_QUOTES (unset)
#           Allow the character sequence `'''  to  signify  a  single  quote
#           within  singly  quoted  strings.   Note  this  does not apply in
#           quoted strings using the format $'...', where a backslashed sin-
#           gle quote can be used.
#    RM_STAR_SILENT (-H) <K> <S> (unset)
#           Do not query the user before executing `rm *' or `rm path/*'.
#    RM_STAR_WAIT (unset)
#           If  querying  the  user  before executing `rm *' or `rm path/*',
#           first wait ten seconds and ignore anything typed in  that  time.
#           This  avoids  the  problem of reflexively answering `yes' to the
#           query when one didn't really mean it.  The wait  and  query  can
#           always be avoided by expanding the `*' in ZLE (with tab).
#    SHORT_LOOPS <C> <Z> (set - NO_SHORT_LOOPS unset)
#           Allow  the  short forms of for, repeat, select, if, and function
#           constructs.
#    SUN_KEYBOARD_HACK (-L) (unset)
#           If a line ends with a backquote, and there are an odd number  of
#           backquotes  on the line, ignore the trailing backquote.  This is
#           useful on some keyboards where the return key is too small,  and
#           the backquote key lies annoyingly close to it.
#
#Job Control
#    AUTO_CONTINUE (unset)
#           With this option set, stopped jobs that are removed from the job
#           table with the disown builtin command are automatically  sent  a
#           CONT signal to make them running.
#    AUTO_RESUME (-W) (unset)
#           Treat  single word simple commands without redirection as candi-
#           dates for resumption of an existing job.
#    BG_NICE (-6) <C> <Z> (set - NO_BG_NICE unset)
#           Run all background jobs at a lower priority.  This option is set
#           by default.
#    CHECK_JOBS <Z> (set - NO_CHECK_JOBS unset)
#           Report  the status of background and suspended jobs before exit-
#           ing a shell with job control; a second attempt to exit the shell
#           will  succeed.   NO_CHECK_JOBS  is best used only in combination
#           with NO_HUP, else such jobs will be killed automatically.
#
#           The check is omitted if the commands run from the previous  com-
#           mand  line  included  a  `jobs' command, since it is assumed the
#           user is aware that there are background or  suspended  jobs.   A
#           `jobs'  command  run from the precmd function is not counted for
#           this purpose.
setopt no_hup
#    HUP <Z> (set - NO_HUP unset)
#           Send the HUP signal to running jobs when the shell exits.
setopt long_list_jobs
#    LONG_LIST_JOBS (-R) (unset)
#           List jobs in the long format by default.
#    MONITOR (-m, ksh: -m) (set)
#           Allow job control.  Set by default in interactive shells.
#    NOTIFY (-5, ksh: -b) <Z> (set - NO_NOTIFY unset)
#           Report the status of background jobs  immediately,  rather  than
#           waiting until just before printing a prompt.
#
#Prompting
#    PROMPT_BANG <K> (unset)
#           If  set,  `!' is treated specially in prompt expansion.  See the
#           section `Prompt Expansion'.
#    PROMPT_CR (+V) <D> (set - NO_PROMPT_CR unset)
#           Print a carriage return just before printing  a  prompt  in  the
#           line  editor.   This  is  on by default as multi-line editing is
#           only possible if the editor knows where the start  of  the  line
#           appears.
#    PROMPT_PERCENT <C> <Z> (set - NO_PROMPT_PERCENT unset)
#           If  set,  `%' is treated specially in prompt expansion.  See the
#           section `Prompt Expansion'.
#    PROMPT_SUBST <K> (unset)
#           If set, parameter expansion, command substitution and arithmetic
#           expansion   are  performed  in  prompts.   Substitutions  within
#           prompts do not affect the command status.
#    TRANSIENT_RPROMPT (unset)
#           Remove any right prompt from display when  accepting  a  command
#           line.   This  may  be useful with terminals with other cut/paste
#           methods.
#
#Scripts and Functions
#    C_BASES (unset)
#           Output hexadecimal numbers in the standard C format, for example
#           `0xFF' instead of the usual `16#FF'.  If the option OCTAL_ZEROES
#           is also set (it is  not  by  default),  octal  numbers  will  be
#           treated  similarly  and hence appear as `077' instead of `8#77'.
#           This option has no effect on the choice of the output base,  nor
#           on  the  output of bases other than hexadecimal and octal.  Note
#           that these formats will be understood on input  irrespective  of
#           the setting of C_BASES.
#    ERR_EXIT (-e, ksh: -e) (unset)
#           If  a command has a non-zero exit status, execute the ZERR trap,
#           if set, and exit.  This is disabled while running initialization
#           scripts.
#    ERR_RETURN (unset)
#           If a command has a non-zero exit status, return immediately from
#           the enclosing function.  The logic  is  identical  to  that  for
#           ERR_EXIT,  except  that an implicit return statement is executed
#           instead of an exit.  This will trigger an exit at the  outermost
#           level of a non-interactive script.
#    EVAL_LINENO <Z> (set - NO_EVAL_LINENO unset)
#           If  set, line numbers of expressions evaluated using the builtin
#           eval are tracked separately of the enclosing environment.   This
#           applies  both to the parameter LINENO and the line number output
#           by the prompt escape %i.  If  the  option  is  set,  the  prompt
#           escape  %N will output the string `(eval)' instead of the script
#           or function name as an indication.   (The two prompt escapes are
#           typically used in the parameter PS4 to be output when the option
#           XTRACE is set.)  If EVAL_LINENO is unset, the line number of the
#           surrounding  script  or  function is retained during the evalua-
#           tion.
#    EXEC (+n, ksh: +n) <D> (set - NO_EXEC unset)
#           Do execute commands.  Without this option, commands are read and
#           checked for syntax errors, but not executed.  This option cannot
#           be turned off in an interactive shell, except when `-n' is  sup-
#           plied to the shell at startup.
#    FUNCTION_ARGZERO <C> <Z> (set - NO_FUNCTION_ARGZERO unset)
#           When  executing  a  shell  function or sourcing a script, set $0
#           temporarily to the name of the function/script.
#    LOCAL_OPTIONS <K> (unset)
#           If this option is set at the point of return from a shell  func-
#           tion,  all  the options (including this one) which were in force
#           upon entry to the function are restored.  Otherwise,  only  this
#           option and the XTRACE and PRINT_EXIT_VALUE options are restored.
#           Hence if this is explicitly unset by a shell function the  other
#           options in force at the point of return will remain so.  A shell
#           function can also guarantee itself a known  shell  configuration
#           with  a  formulation  like  `emulate  -L  zsh'; the -L activates
#           LOCAL_OPTIONS.
#    LOCAL_TRAPS <K> (unset)
#           If this option is set when a signal trap is set inside  a  func-
#           tion,  then the previous status of the trap for that signal will
#           be restored when the function exits.  Note that this option must
#           be  set  prior  to  altering  the  trap behaviour in a function;
#           unlike LOCAL_OPTIONS, the value on exit  from  the  function  is
#           irrelevant.   However,  it  does  not  need to be set before any
#           global trap for that to be correctly  restored  by  a  function.
#           For example,
#
#                  unsetopt localtraps
#                  trap - INT
#                  fn() { setopt localtraps; trap '' INT; sleep 3; }
#
#           will  restore  normally  handling  of  SIGINT after the function
#           exits.
#    MULTIOS <Z> (set - NO_MULTIOS unset)
#           Perform implicit tees or cats  when  multiple  redirections  are
#           attempted (see the section `Redirection').
#    OCTAL_ZEROES <S> (unset)
#           Interpret  any integer constant beginning with a 0 as octal, per
#           IEEE Std 1003.2-1992 (ISO 9945-2:1993).  This is not enabled  by
#           default as it causes problems with parsing of, for example, date
#           and time strings with leading zeroes.
#    TYPESET_SILENT (unset)
#           If this is unset, executing any of the `typeset' family of  com-
#           mands with no options and a list of parameters that have no val-
#           ues to be assigned but already exist will display the  value  of
#           the  parameter.   If  the option is set, they will only be shown
#           when parameters are selected with the `-m' option.   The  option
#           `-p' is available whether or not the option is set.
#    VERBOSE (-v, ksh: -v) (unset)
#           Print shell input lines as they are read.
#    XTRACE (-x, ksh: -x) (unset)
#           Print commands and their arguments as they are executed.
#
#Shell Emulation
#    BSD_ECHO <S> (unset)
#           Make  the  echo builtin compatible with the BSD echo(1) command.
#           This disables  backslashed  escape  sequences  in  echo  strings
#           unless the -e option is specified.
#    CSH_JUNKIE_HISTORY <C> (unset)
#           A history reference without an event specifier will always refer
#           to the previous command.  Without this option,  such  a  history
#           reference  refers to the same event as the previous history ref-
#           erence, defaulting to the previous command.
#    CSH_JUNKIE_LOOPS <C> (unset)
#           Allow loop bodies to take the form `list; end'  instead  of  `do
#           list; done'.
#    CSH_JUNKIE_QUOTES <C> (unset)
#           Changes  the  rules  for single- and double-quoted text to match
#           that of csh.  These require that embedded newlines  be  preceded
#           by  a backslash; unescaped newlines will cause an error message.
#           In double-quoted strings, it is made impossible to  escape  `$',
#           ``'  or  `"' (and `\' itself no longer needs escaping).  Command
#           substitutions are only expanded once, and cannot be nested.
#    CSH_NULLCMD <C> (unset)
#           Do not use the values of NULLCMD and  READNULLCMD  when  running
#           redirections  with no command.  This make such redirections fail
#           (see the section `Redirection').
#    KSH_ARRAYS <K> <S> (unset)
#           Emulate ksh array handling as  closely  as  possible.   If  this
#           option  is  set, array elements are numbered from zero, an array
#           parameter without subscript refers to the first element  instead
#           of  the  whole  array, and braces are required to delimit a sub-
#           script (`${path[2]}' rather than just `$path[2]').
#    KSH_AUTOLOAD <K> <S> (unset)
#           Emulate ksh function autoloading.  This means that when a  func-
#           tion  is  autoloaded, the corresponding file is merely executed,
#           and must define the function itself.  (By default, the  function
#           is  defined to the contents of the file.  However, the most com-
#           mon ksh-style case - of the file containing only a simple  defi-
#           nition of the function - is always handled in the ksh-compatible
#           manner.)
#    KSH_OPTION_PRINT <K> (unset)
#           Alters the way options settings are printed: instead of separate
#           lists  of  set  and unset options, all options are shown, marked
#           `on' if they are in the non-default state, `off' otherwise.
#    KSH_TYPESET <K> (unset)
#           Alters the way arguments to  the  typeset  family  of  commands,
#           including  declare,  export, float, integer, local and readonly,
#           are processed.  Without this option,  zsh  will  perform  normal
#           word  splitting  after  command and parameter expansion in argu-
#           ments of an assignment; with it, word splitting  does  not  take
#           place in those cases.
setopt posix_builtins
#    POSIX_BUILTINS <K> <S> (unset)
#           When  this option is set the command builtin can be used to exe-
#           cute shell builtin commands.   Parameter  assignments  specified
#           before  shell  functions and special builtins are kept after the
#           command completes unless the special builtin  is  prefixed  with
#           the  command  builtin.   Special  builtins are ., :, break, con-
#           tinue, declare, eval, exit, export,  integer,  local,  readonly,
#           return, set, shift, source, times, trap and unset.
#    SH_FILE_EXPANSION <K> <S> (unset)
#           Perform  filename expansion (e.g., ~ expansion) before parameter
#           expansion, command substitution, arithmetic expansion and  brace
#           expansion.  If this option is unset, it is performed after brace
#           expansion, so things like `~$USERNAME' and `~{pfalstad,rc}' will
#           work.
#    SH_NULLCMD <K> <S> (unset)
#           Do  not  use  the  values  of NULLCMD and READNULLCMD when doing
#           redirections, use `:' instead (see the section `Redirection').
#    SH_OPTION_LETTERS <K> <S> (unset)
#           If this option is set the shell tries to interpret single letter
#           options  (which  are  used  with  set and setopt) like ksh does.
#           This also affects the value of the - special parameter.
#    SH_WORD_SPLIT (-y) <K> <S> (unset)
#           Causes field splitting to be  performed  on  unquoted  parameter
#           expansions.   Note  that this option has nothing to do with word
#           splitting.  (See the section `Parameter Expansion'.)
#    TRAPS_ASYNC (unset)
#           While waiting for a program to  exit,  handle  signals  and  run
#           traps  immediately.   Otherwise  the  trap  is run after a child
#           process has exited.  Note this does  not  affect  the  point  at
#           which  traps  are  run for any case other than when the shell is
#           waiting for a child process.
#
#Shell State
#    INTERACTIVE (-i, ksh: -i) (set)
#           This is an interactive shell.  This option is set upon initiali-
#           sation  if  the  standard  input is a tty and commands are being
#           read from standard input.  (See the discussion  of  SHIN_STDIN.)
#           This  heuristic may be overridden by specifying a state for this
#           option on the command line.  The value of this option cannot  be
#           changed anywhere other than the command line.
#    LOGIN (-l, ksh: -l)
#           This  is  a  login shell.  If this option is not explicitly set,
#           the shell is a login shell if the first character of the argv[0]
#           passed to the shell is a `-'.
#    PRIVILEGED (-p, ksh: -p) (unset)
#           Turn  on  privileged  mode.  This  is  enabled  automatically on
#           startup if the effective user (group) ID is  not  equal  to  the
#           real user (group) ID.  Turning this option off causes the effec-
#           tive user and group IDs to be set to the  real  user  and  group
#           IDs.  This  option disables sourcing user startup files.  If zsh
#           is invoked as `sh' or `ksh' with this option set, /etc/suid_pro-
#           file  is  sourced  (after  /etc/profile  on interactive shells).
#           Sourcing ~/.profile is disabled and  the  contents  of  the  ENV
#           variable  is ignored. This option cannot be changed using the -m
#           option of setopt and unsetopt, and changing it inside a function
#           always  changes  it  globally  regardless  of  the LOCAL_OPTIONS
#           option.
#    RESTRICTED (-r) (unset)
#           Enables restricted mode.  This option cannot  be  changed  using
#           unsetopt,  and  setting  it  inside a function always changes it
#           globally regardless of the LOCAL_OPTIONS option.  See  the  sec-
#           tion `Restricted Shell'.
#    SHIN_STDIN (-s, ksh: -s) (set)
#           Commands  are  being read from the standard input.  Commands are
#           read from standard input if no command is specified with -c  and
#           no  file of commands is specified.  If SHIN_STDIN is set explic-
#           itly on the command line, any argument that would otherwise have
#           been  taken as a file to run will instead be treated as a normal
#           positional parameter.   Note  that  setting  or  unsetting  this
#           option on the command line does not necessarily affect the state
#           the option will have while the shell is running - that is purely
#           an  indicator of whether on not commands are actually being read
#           from standard input.  The value of this option cannot be changed
#           anywhere other than the command line.
#    SINGLE_COMMAND (-t, ksh: -t) (unset)
#           If  the  shell  is reading from standard input, it exits after a
#           single command has been executed.  This  also  makes  the  shell
#           non-interactive, unless the INTERACTIVE option is explicitly set
#           on the command line.  The value of this option cannot be changed
#           anywhere other than the command line.
#
#Zle
#    BEEP (+B) <D> (set - NO_BEEP unset)
#           Beep on error in ZLE.
#    EMACS (unset - together with VI!)
#           If  ZLE  is  loaded,  turning  on this option has the equivalent
#           effect of `bindkey -e'.  In addition, the VI  option  is  unset.
#           Turning it off has no effect.  The option setting is not guaran-
#           teed to reflect the current keymap.  This option is provided for
#           compatibility; bindkey is the recommended interface.
#    OVERSTRIKE (unset)
#           Start up the line editor in overstrike mode.
#    SINGLE_LINE_ZLE (-M) <K> (unset)
#           Use single-line command line editing instead of multi-line.
#    VI (unset - together with EMACS!)
#           If  ZLE  is  loaded,  turning  on this option has the equivalent
#           effect of `bindkey -v'.  In addition, the EMACS option is unset.
#           Turning it off has no effect.  The option setting is not guaran-
#           teed to reflect the current keymap.  This option is provided for
#           compatibility; bindkey is the recommended interface.
#    ZLE (-Z) (both set and unset!)
#           Use  the  zsh line editor.  Set by default in interactive shells
#           connected to a terminal.
