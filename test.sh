#!/usr/bin/env bash

set -e
set -o pipefail
IFS=$'\n'

# install additional tools
[[ ! -f "$(command -v mdl)" ]] && gem install mdl
[[ ! -f "$(command -v yaml-lint)" ]] && gem install yaml-lint

# create a list of mdl rules to ignore
if [[ ! -f ~/.mdlrc ]] ; then
    cat << EOF > ~/.mdlrc
rules "~MD007", "~MD013","~MD014","~MD033", "~MD024", "~MD040", "~MD046"
EOF
fi

# find and lint files
for f in $(find . -type f -not \( -iwholename '*.git*' -o -iwholename '*.tmp*'  \) | sort -u) ; do
    if file "$f" | grep -i --quiet "\\(bash\\|shell\\) script" ; then
        shellcheck "$f"
    elif file "$f" | grep -i --quiet "text" ; then
        if [[ "$f" = *.md ]]; then
            mdl "$f"
        elif [[ "$f" = *.yaml || "$f" = *.yml ]]; then
            yaml-lint -i -q "$f"
        fi
    fi
done

# testing few additional things
# Using custom aliases 
pro # should open ~/Projects
.. # should run cd ..

# using custom functions
mcd Test # should create folder Test and open it

# check git config
if $(git config --global user.name) == "Anton Efimov" ; then
    return 0
else
    return 1
fi

# check installed brew packages
tldr -v