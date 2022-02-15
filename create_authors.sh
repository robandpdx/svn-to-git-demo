#!/bin/bash

source ./settings.sh

echo "Let's see who's committed code to $SVN_REPO"
svn log -q $SVN_REPO | grep -e '^r' | awk 'BEGIN { FS = "|" } ; { print $2 }' | sort | uniq > svn_users.txt

while read user
do
	echo "looking for $user"
	if grep $user ldap_users.txt >> authors.txt ; then
		echo "found $user in ldap"
	else
		echo "$user not found in ldap, they are now Tony Clifton"
		echo "$user = Clifton, Tony <tony.clifton@sample.com>" >> authors.txt
	fi
done <svn_users.txt
