#!/bin/bash
# Based on https://github.com/haarg/convert-git-dbic
set -u
set -e
git for-each-ref –format=’%(refname)’ refs/remotes/svn/tags/* | while read r; do
tag=${r#refs/remotes/svn/tags/}
sha1=$(git rev-parse “$r”)
commiterName=”$(git show -s –pretty=’format:%an’ “$r”)”
commiterEmail=”$(git show -s –pretty=’format:%ae’ “$r”)”
commitDate=”$(git show -s –pretty=’format:%ad’ “$r”)”
# Print the commit subject and body separated by a newline
git show -s –pretty=’format:%s%n%n%b’ “$r” | \
	env GIT_COMMITTER_EMAIL=”$commiterEmail” GIT_COMMITTER_DATE=”$commitDate” GIT_COMMITTER_NAME=”$commiterName” \
	git tag -a -m “Tag: ${tag} sha1: ${sha1} using ‘${commiterName}’, ‘${commiterEmail}’ on ‘${commitDate}'” “$tag” “$sha1”
# Remove the svn/tags/* ref
git update-ref -d “$r”
done
