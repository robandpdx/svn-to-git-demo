#!/bin/bash

source ./settings.sh

svnadmin create $PRIVATE_SVN_REPO
cp pre-revprop-change $PRIVATE_SVN_REPO/hooks/pre-revprop-change
svnsync init file://$BASE_DIR/$PRIVATE_SVN_REPO $SVN_REPO
svnsync sync file://$BASE_DIR/$PRIVATE_SVN_REPO
