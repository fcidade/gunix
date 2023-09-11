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

should_equal "$(/bin/pwd)"                                  "$(./pwd)"
should_equal "$(/bin/pwd more)"                             "$(./pwd more)"
should_equal "$(/bin/pwd more 2>&1 >/dev/null)"             "$(./pwd more 2>&1 >/dev/null)"
should_equal "$(/bin/pwd more params)"                      "$(./pwd more params)"
should_equal "$(/bin/pwd -invalidoption)"                   "$(./pwd -invalidoption)"
should_equal "$(/bin/pwd -L)"                               "$(./pwd -L)"
should_equal "$(/bin/pwd -P)"                               "$(./pwd -P)"
should_equal "$(cd examples/symlink_dir && /bin/pwd -L)"    "$(cd examples/symlink_dir && go run ../../../pwd -L)"
should_equal "$(cd examples/symlink_dir && /bin/pwd -P)"    "$(cd examples/symlink_dir && go run ../../../pwd -P)"