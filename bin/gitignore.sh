#! /bin/bash
GITIGNORE_DIR="$HOME/github/gitignore"
for i in Django.gitignore Global/OSX.gitignore Global/SublimeText.gitignore Global/TextMate.gitignore Global/vim.gitignore Objective-C.gitignore Python.gitignore
do
    echo -e "# {{{ https://github.com/github/gitignore/blob/master/$i\n"
    cat $GITIGNORE_DIR/$i
    echo -e "# }}} https://github.com/github/gitignore/blob/master/$i\n"
done
