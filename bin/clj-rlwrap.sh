#! /usr/bin/env bash

# clj - Clojure launcher script
# copied from http://trac.macports.org/browser/trunk/dports/lang/clojure/files/clj-rlwrap.sh

## prevent referencing undefined variables (which default to "")
set -o nounset
## ignore failing commands
set -o errexit
## make pipe fail when any command in the pipe fails
## use this when using errexit
## Otherwise, it only checks that the last command succeeds
set -o pipefail

BREAK_CHARS="\(\){}[],^%\$#@\"\";:''|\\"

cljjar='/usr/local/Cellar/clojure/1.4.0/clojure-1.4.0.jar'
cljclass='clojure.main'
cljcompletions="$HOME/.clj-completions"

dir=$0
while [ -h "$dir" ]; do
  ls=`ls -ld "$dir"`
  link=`expr "$ls" : '.*-> \(.*\)$'`

  if expr "$link" : '/.*' > /dev/null; then
    dir="$link"
  else
    dir=`dirname "$dir"`"/$link"
  fi
done

dir=`dirname $dir`
dir=`cd "$dir" > /dev/null && pwd`
cp="${PWD}:${cljjar}"

# Add extra jars as specified by `.clojure` file
# Borrowed from <http://github.com/mreid/clojure-framework>
if [ -f .clojure ]; then
  cp=$cp:`cat .clojure`
fi

if [ $# -eq 0 ]; then
  rlwrap --remember -c -b $BREAK_CHARS -f $cljcompletions java -cp $cp $cljclass
else
  exec java -classpath $cp $cljclass $*
fi
