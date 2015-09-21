#! /usr/bin/env sh

find templates \
    -type f \
    -name "*.html" \
    -exec \
        tidy \
            --indent-spaces 4 \
            --wrap 0 \
            --wrap-asp no \
            --fix-uri no \
            --tidy-mark no \
            --break-before-br yes \
            --indent-attributes yes \
            --vertical-space yes \
            -file errors.txt \
            -modify \
            -utf8 \
            -indent \
            {} \;
exit 0
            # this tidy option doesn't work with --wrap-asp
            --show-body-only yes \
