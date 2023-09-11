#!/bin/bash

# Testing ---
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

function should_equal {
    if [ "$1" == "$2" ]; then
        echo -e "$GREEN[SUCCESS] $1 = $2"
        return
    else
        echo -e "$RED [ERROR] expect equal, but got: $1 and $2"
        exit 1
    fi
}
# --- Testing 

go build

should_equal "$(/bin/cat ./manual)"                                  "$(./cat ./manual)"
should_equal "$(/bin/cat aaa eee iii ooo uuu 2>&1 >/dev/null)"       "$(./cat aaa eee iii ooo uuu 2>&1 >/dev/null)"
should_equal "$(/bin/cat cat.go manual cat.go go.mod)"               "$(./cat cat.go manual cat.go go.mod)"
should_equal "$(/bin/cat -n manual)"                                 "$(./cat -n manual)"
should_equal "$(/bin/cat -b manual)"                                 "$(./cat -b manual)"
# should_equal "$(/bin/cat more 2>&1 >/dev/null)"             "$(./cat more 2>&1 >/dev/null)"

# TODO: Cat without args