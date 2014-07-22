#!/bin/bash

# might switch to some other language later


interceptor() {
    if test $# == 0 ; then
        # USAGE
        cat <<EOF
$0 is a script that adds a thin layer over bower and git.

Any command not handled by this script is actually forwarded to bower.
Run "bower" or "$0 bower"
EOF
        exit
    fi

    case "$1" in
        build)
            jekyll build --plugins template/_plugins --layouts template/_layouts --config template/_config.yml
            ;;
        *) # anything else with be skipped
            return
            ;;
    esac
    exit
}

# TODO, generate .gitignore file?


# by default, delegating to bower
interceptor "$@"
bower "$@"
