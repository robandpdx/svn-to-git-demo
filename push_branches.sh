#!/bin/bash
. ./settings.sh
set -u
set -e
cd $GIT_REPO
for REF in $(git for-each-ref --format='%(refname)' refs/remotes/svn/ | grep -v /tags/); do
    BRANCH_NAME=${REF#refs/remotes/origin/}
    if [ "$BRANCH_NAME" != "trunk" ]; then
        echo "Push branch: $BRANCH_NAME"
        git push -u origin "$REF":refs/heads/$BRANCH_NAME
    fi
done
cd ..``