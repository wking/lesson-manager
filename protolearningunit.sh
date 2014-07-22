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

#    case "$1" in
#    echo go
}



# by default, delegating to bower
interceptor "$@"
bower "$@"
