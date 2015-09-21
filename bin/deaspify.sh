#! /usr/bin/env sh

find templates \
    -type f \
    -name \*.html \
    -exec sed \
        -i '' \
        -e 's <% {% g; s %> %} g' {} \;
