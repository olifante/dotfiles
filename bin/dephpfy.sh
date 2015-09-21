#! /usr/bin/env sh

find templates \
    -type f \
    -name \*.html \
    -exec sed \
        -i '' \
        -e 's <?php {% g; s ?> %} g' {} \;
