find . -type f -name \*.m -or -name \*.h | xargs /usr/local/bin/uncrustify -l OC -q -c objective-c.cfg --no-backup
