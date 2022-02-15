#!/bin/bash

. ./settings.sh

svnsync sync file://$BASE_DIR/$PRIVATE_SVN_REPO

cd $GIT_REPO
git svn fetch
cd ..

