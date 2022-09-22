#!/bin/bash
. ./settings.sh
set -u
set -e
cd $GIT_REPO
for REF in $(git for-each-ref --format='%(refname)' refs/remotes/svn/ | grep /tags/); do
    TAG_NAME=${REF#refs/remotes/origin/tags/}
    echo "Push tag: $TAG_NAME"
    git push -u origin "$REF":refs/tags/$TAG_NAME
done
cd ..