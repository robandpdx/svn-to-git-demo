#!/bin/bash

source ./settings.sh

echo $BASE_DIR/$PRIVATE_SVN_REPO
echo "Creating local git repo"
git init $GIT_REPO
cd $GIT_REPO

echo "Configuring svn sync"
git svn init \
--no-metadata \
--prefix=svn/ \
-Ttrunk \
-ttags \
-bbranches \
file://$BASE_DIR/$PRIVATE_SVN_REPO

echo "Syncing svn"
git config svn.authorsfile $BASE_DIR/authors.txt
#git config svn.noMetadata
git svn fetch
